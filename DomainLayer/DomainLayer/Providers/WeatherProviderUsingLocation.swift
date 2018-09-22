//
//  WeatherProviderUsingLocation.swift
//  DomainLayer
//
//  Created by Nikola Matijevic on 19/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation


public protocol WeatherProviderUsingLocation {
    func fetch(for location: UserLocation, unit: TemperatureUnit, completion: @escaping (Response<CurrentWeather>) -> Void)
}
