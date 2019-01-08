//
//  URLsRouter.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/7/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import Foundation
import Alamofire

enum ServerAuthentication: String {
    case userName = "admin@boot.com"
    case password = "admin"
}

enum URLs: String {
    
    case mainDomain = "45.55.43.15:9090"
    private static let base = "https://\(mainDomain.rawValue)/api/machine?"
    case serverInfo = "page=#page&size=#size"
    
    var path: String {
        switch self {
        case .mainDomain:
            return URLs.mainDomain.rawValue
        case .serverInfo:
            return "\(URLs.base)\(self.rawValue)"
        }
    }
    
}
