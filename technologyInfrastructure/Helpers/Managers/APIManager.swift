//
//  APIManager.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/7/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import Foundation
import Alamofire

enum RequestMethod {
    case get
    case post
}

enum RequestEncoding {
    case defaultEncoding
}

protocol RequestProtocol {
    func willLoad()
    func didLoadData<T: Codable>(data: T)
    func didFailWith(message: String)
}

protocol APIManagerProtocol {
    func requestDataFor<T: Codable>(_ requestUrl: String,
                                    requestMethod: RequestMethod,
                                    parameters: [String: Any]?,
                                    requestParametersEncoding: RequestEncoding,
                                    headers: [String: String]?,
                                    onSuccess: @escaping (_ response: T) -> Void,
                                    onFailure: @escaping (_ error: String) -> Void)
}

class APIManager: APIManagerProtocol {
    
    func requestDataFor<T>(_ requestUrl: String,
                           requestMethod: RequestMethod = .get,
                           parameters: [String: Any]? = nil,
                           requestParametersEncoding: RequestEncoding = .defaultEncoding,
                           headers: [String: String]? = nil,
                           onSuccess: @escaping (_ response: T) -> Void,
                           onFailure: @escaping (_ error: String) -> Void) where T : Decodable, T : Encodable {
        
        handleAuthenticationChallenge()
        
        APIManager.Manager.request(requestUrl,
                                   method: requestMethodAsHttpMethod(method: requestMethod),
                                   parameters: parameters,
                                   encoding: requestParametersEncodingAsURLEncoding(requestParametersEncoding: requestParametersEncoding),
                                   headers: headers)
            .authenticate(user: ServerAuthentication.userName.rawValue, password: ServerAuthentication.password.rawValue)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if response.result.error == nil && response.result.value != nil {
                        
                        guard let result = response.data else {
                            onFailure("couldn't get data")
                            return
                        }
                        
                        guard let resultDecoded = T.decode(json: result, asA: T.self) else {
                            onFailure("Error parsing user data")
                            return
                        }
                        
                        onSuccess(resultDecoded)
                        
                    } else {
                        
                        onFailure("Error parsing user data")
                    }
                    
                case .failure(let error):
                    
                    onFailure(error.localizedDescription)
                }
        }
    }
    
    private static var Manager: Alamofire.SessionManager = {
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [ URLs.mainDomain.path: .disableEvaluation ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    private func handleAuthenticationChallenge() {
        
        let delegate: Alamofire.SessionDelegate = APIManager.Manager.delegate
        delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = APIManager.Manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            
            return (disposition, credential)
        }
    }
    
    private func requestMethodAsHttpMethod(method: RequestMethod) -> HTTPMethod {
        
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    private func requestParametersEncodingAsURLEncoding(requestParametersEncoding: RequestEncoding) -> URLEncoding {
        
        switch requestParametersEncoding {
        case .defaultEncoding:
            return .default
        }
    }
}
