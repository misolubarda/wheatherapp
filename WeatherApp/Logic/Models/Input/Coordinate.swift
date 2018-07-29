//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/29/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

struct Coordinate: Decodable {
    enum CodingKeys: String, CodingKey {
        case lat
        case long = "lon"
    }

    let lat: Double
    let long: Double
}
