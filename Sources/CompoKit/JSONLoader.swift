//
//  JSONLoader.swift
//  ScoresAppUIKit
//
//  Created by Jon Gonzalez on 10/3/25.
//

import Foundation

public protocol JSONLoader {}

extension JSONLoader {
    public func load<T>(url: URL, type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Codable {
        let data = try Data(contentsOf: url)
        return try decoder.decode(type, from: data)
    }

    public func save<T>(url: URL, data: T, encoder: JSONEncoder = JSONEncoder()) throws where T: Codable {
        let jsonData = try encoder.encode(data)
        try jsonData.write(to: url, options: [.atomic, .completeFileProtection])
    }
}
