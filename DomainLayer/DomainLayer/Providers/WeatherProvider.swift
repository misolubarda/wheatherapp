//
//  WeatherProvider.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 8/6/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol WeatherProvider {
    func fetch(forCity city: String, unit: TemperatureUnit, completion: @escaping (Response<CurrentWeather>) -> Void)
}
