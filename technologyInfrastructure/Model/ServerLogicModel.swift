//
//  ServerLogicModel.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import Foundation

class ServerLogicModel: NSObject {
    
    func brokenServers(_ servers: [DeviceModel]) -> [DeviceModel] {
        
        return servers.filter { (server) -> Bool in
            
            return (server.status?.id)! != 1 && (server.status?.id)! <= 4
        }
    }
}
