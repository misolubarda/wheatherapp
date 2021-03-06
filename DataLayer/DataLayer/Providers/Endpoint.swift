//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/29/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

enum Endpoint {
    case currentWeather(city: String, unit: TemperatureUnit)
    case temperatureForecast(city: String, unit: TemperatureUnit)
    case currentUvIndex(coordinate: Coordinate)
    case currentWeatherWithLocation(location: UserLocation)

    var path: String {
        switch self {
        case .currentWeather:
            return "weather"
        case .currentUvIndex:
            return "uvi"
        case .temperatureForecast:
            return "forecast"
        case .currentWeatherWithLocation:
            return "weather"
        }
    }

    var inputParameters: String {
        switch self {
        case let .currentWeather(city: city, unit: unit):
            return "&q=\(city)&units=\(unit.rawValue)"
        case let .currentUvIndex(coordinate: coordinate):
            return "&lat=\(coordinate.lat)&lon=\(coordinate.long)"
        case let .temperatureForecast(city: city, unit: unit):
            return "&q=\(city)&units=\(unit.rawValue)"
        case let .currentWeatherWithLocation(location: location):
            return "&lat=\(location.latitude)&lon=\(location.longitude)"
        }
    }
}
