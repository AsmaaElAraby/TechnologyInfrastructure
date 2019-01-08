//
//  Encodable.swift
//  technologyInfrastructure
//
//  Created by Asma on 1/6/19.
//  Copyright © 2019 Asmaa Mostafa. All rights reserved.
//

import Foundation

extension Encodable {
    
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self), options: .mutableLeaves)) as? [String: Any] ?? [:]
    }
    
    func encode<T: Codable>(data: T) -> String? {

        if let encodedData = try? JSONEncoder().encode(data), let dataAsString = parseDataAsString(encodedData) {
            return dataAsString
        }
        return nil
    }
    
    static func decode<T: Decodable>(json: String, asA thing: T.Type) -> T? {
    
        let data = Data(json.utf8)
        do {
            return try JSONDecoder().decode(thing.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    static func decode<T: Decodable>(json: Data, asA thing: T.Type) -> T? {
        
        let jsonAsString = String(decoding: json, as: UTF8.self)
        let data = Data(jsonAsString.utf8)
        do {
            return try JSONDecoder().decode(thing.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    func parseDataAsString(_ rawData: Data) -> String? {
        var dataString = NSString(data: rawData, encoding: String.Encoding.utf8.rawValue)
        dataString = dataString?.replacingOccurrences(of: "NULL", with: "null") as NSString?
        return dataString as String?
    }
}

protocol JSONDecoderable {
    static func decodeJsonData<T: Codable>(_ parcelable: T.Type, _ jsonData: Data, _ isObject: Bool) -> Any?
}
