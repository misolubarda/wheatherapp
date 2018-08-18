//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/26/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public struct CurrentWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case main
        case city = "name"
        case coordinate = "coord"
    }

    struct Main: Decodable {
        enum CodingKeys: String, CodingKey {
            case temp
            case humidity
            case minTemp = "temp_min"
            case maxTemp = "temp_max"
        }

        let temp: Double
        let humidity: Double
        let minTemp: Double
        let maxTemp: Double
    }

    let city: String
    let coordinate: Coordinate
    let temperature: Double
    let humidity: Double
    let minTemp: Double
    let maxTemp: Double

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)
        temperature = try container.decode(Main.self, forKey: .main).temp
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
        humidity = try container.decode(Main.self, forKey: .main).humidity
        minTemp = try container.decode(Main.self, forKey: .main).minTemp
        maxTemp = try container.decode(Main.self, forKey: .main).maxTemp

    }
}
