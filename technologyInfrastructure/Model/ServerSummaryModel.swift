//
//  ServerSummaryModel.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import Foundation

struct ServerSummaryModel: Codable {
    
    let devicesInfoList: [DeviceModel]?
    
//    var first: Int
//    let last: String?
    let number: Int?
    let numberOfElements: Int?
    let size: Int?
    let totalElements: Int?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case devicesInfoList = "content"
//        case first
//        case last
        case number
        case numberOfElements
        case size
        case totalElements
        case totalPages
    }
}

struct DeviceModel: Codable {
    
    let ipAddress: String?
    let ipSubnetMask: String?
    let name: String?
    let status: Status?
}

struct Status: Codable {
    
    let id: Int?
    let legacyValue: String?
    let statusValue: String?
}
