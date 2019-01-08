//
//  ServerInfoController.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/8/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import Foundation

protocol ServerInfoProtocol {
    func loadServersInfoFor(_ page: Int)
    func getBrokenServers(_ servers: [DeviceModel]) -> [DeviceModel]
}

class ServerInfoController: ServerInfoProtocol {
    
    private let pageItemsSize: Int = 10
    
    private let requestProtocol: RequestProtocol!
    init(requestProtocol: RequestProtocol) {
        self.requestProtocol = requestProtocol
    }
    
    func loadServersInfoFor(_ page: Int) {
        
        requestProtocol.willLoad()
        
        let manager = APIManager()
        manager.requestDataFor(URLs.serverInfo.path.replacingOccurrences(of: "#page", with: "\(page)").replacingOccurrences(of: "#size", with: "\(pageItemsSize)"), onSuccess: { [weak self] (result: ServerSummaryModel ) in
            
            self?.requestProtocol.didLoadData(data: result)
        
        }) { [weak self] (error: String) in
        
            self?.requestProtocol.didFailWith(message: error)
        }
    }
    
    func getBrokenServers(_ servers: [DeviceModel]) -> [DeviceModel] {
        
        let model = ServerLogicModel()
        return model.brokenServers(servers)
    }
}
