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
        case temperature = "main.temp"
        case city = "name"
    }

    let city: String
    let temperature: Double
}

enum TemperatureUnit: String {
    case metric, imperial, kelvin
}
