//
//  CurrentWeatherProvider.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/26/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

public class CurrentWeatherProvider: WeatherProvider {
    public init() {}

    public func fetch(forCity city: String, unit: TemperatureUnit, completion: @escaping (Response<CurrentWeather>) -> Void) {
        guard let request = Request(endpoint: .currentWeather(city: city, unit: unit)).urlRequest else { return }
        WebService(session: DataNetworkSession()).execute(request, callback: completion)
    }
}