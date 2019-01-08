//
//  ServerInfoControllerTests.swift
//  TechnologyInfrastructureTests
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import XCTest
@testable import TechnologyInfrastructure

class ServerInfoControllerTests: XCTestCase {
    
    private var serverInfoController: ServerInfoProtocol! = nil
    private let requestProtocolMock = RequestProtocolMock()
    override func setUp() {
        super.setUp()
        
        serverInfoController = ServerInfoController(requestProtocol: requestProtocolMock as RequestProtocol)
    }
    
    override func tearDown() {
        super.tearDown()
        
        serverInfoController = nil
    }
    
    func testLoadingServersInfoRequestIsCallingServerWithoutInternetAvailable() {
        
        serverInfoController.loadServersInfoFor(0)
        wait(for: 2)
        XCTAssertTrue(requestProtocolMock.willLoadRequest)
        XCTAssertNil(requestProtocolMock.didLoadRequestData)
        XCTAssertEqual(requestProtocolMock.didFailLoadingRequestWithMessage, "The Internet connection appears to be offline.")
    }
    
    func testLoadingServersInfoRequestIsCallingServerWithInternetAvailable() {
        
        serverInfoController.loadServersInfoFor(0)
        wait(for: 2)
        XCTAssertTrue(requestProtocolMock.willLoadRequest)
        XCTAssertNotNil(requestProtocolMock.didLoadRequestData)
        XCTAssertEqual(requestProtocolMock.didFailLoadingRequestWithMessage, "")
    }
    
    func testLoadingServersInfoResultIsOfTypeServerSummaryModelWithInternetAvailable() {
        
        serverInfoController.loadServersInfoFor(0)
        wait(for: 2)
        XCTAssertTrue(requestProtocolMock.willLoadRequest)
        XCTAssertNotNil(requestProtocolMock.didLoadRequestData)
        assert(requestProtocolMock.didLoadRequestData is ServerSummaryModel)
        XCTAssertEqual(requestProtocolMock.didFailLoadingRequestWithMessage, "")
    }
    
    func testFilteringBrokenServers() {
        
        var filteredList = serverInfoController.getBrokenServers([])
        XCTAssertEqual(filteredList.count, 0)
        
        let devicesList: [DeviceModel] = [DeviceModel(ipAddress: "192.168.1.1", ipSubnetMask: "255.255.255.0", name: "device1", status: Status(id: 1, legacyValue: "legacyValue", statusValue: "statusValue")),
                                          DeviceModel(ipAddress: "192.168.1.2", ipSubnetMask: "255.255.255.0", name: "device2", status: Status(id: 2, legacyValue: "legacyValue", statusValue: "statusValue")),
                                          DeviceModel(ipAddress: "192.168.1.3", ipSubnetMask: "255.255.255.0", name: "device3", status: Status(id: 3, legacyValue: "legacyValue", statusValue: "statusValue")),
                                          DeviceModel(ipAddress: "192.168.1.4", ipSubnetMask: "255.255.255.0", name: "device4", status: Status(id: 4, legacyValue: "legacyValue", statusValue: "statusValue")),
                                          DeviceModel(ipAddress: "192.168.1.7", ipSubnetMask: "255.255.255.0", name: "device7", status: Status(id: 7, legacyValue: "legacyValue", statusValue: "statusValue"))]
        
        filteredList = serverInfoController.getBrokenServers(devicesList)
        XCTAssertEqual(filteredList.count, 3)
    }
}
