//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/26/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case main
        case city = "name"
        case coordinate = "coord"
    }

    struct Main: Decodable {
        let temp: Double
    }

    let city: String
    let coordinate: Coordinate
    let temperature: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)
        temperature = try container.decode(Main.self, forKey: .main).temp
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
    }
}
