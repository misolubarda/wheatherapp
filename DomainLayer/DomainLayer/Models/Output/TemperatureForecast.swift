//
//  TemperatureForecast.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 8/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public struct TemperatureForecast: Decodable {
    enum CodingKeys: String, CodingKey {
        case list
    }

    let temperatures: [Double]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let list = try container.decode([ListEntry].self, forKey: .list)
        temperatures = list.map { $0.temperature }
    }
}

private struct ListEntry: Decodable {
    enum CodingKeys: String, CodingKey {
        case main
    }

    struct Main: Decodable {
        let temp: Double
    }

    let temperature: Double

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(Main.self, forKey: .main).temp
    }
}
