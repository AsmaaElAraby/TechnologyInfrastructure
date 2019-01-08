//
//  RequestProtocolMock.swift
//  TechnologyInfrastructureTests
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import XCTest
@testable import TechnologyInfrastructure

class RequestProtocolMock: RequestProtocol {
    
    var willLoadRequest = false
    var didLoadRequestData: Codable? = nil
    var didFailLoadingRequestWithMessage: String = ""
    
    func willLoad() {
        willLoadRequest = true
    }
    
    func didLoadData<T: Codable>(data: T) {
        didLoadRequestData = data
    }
    
    func didFailWith(message: String) {
        didFailLoadingRequestWithMessage = message
    }
}

