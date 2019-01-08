//
//  TechnologyInfrastructureTests.swift
//  TechnologyInfrastructureTests
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import XCTest
@testable import TechnologyInfrastructure

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
