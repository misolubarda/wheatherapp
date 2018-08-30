//
//  TemperatureForecastProvider.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 8/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol TemperatureForecastProvider {
    func fetch(forCity city: String, unit: TemperatureUnit, completion: @escaping (Response<TemperatureForecast>) -> Void)
}
