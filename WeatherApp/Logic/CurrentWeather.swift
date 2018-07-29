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
    }

    struct Main: Decodable {
        let temp: Double
    }

    let city: String
    let temperature: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)
        temperature = try container.decode(Main.self, forKey: .main).temp
    }
}

enum TemperatureUnit: String {
    case metric, imperial, kelvin
}
