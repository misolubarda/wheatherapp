//
//  OWMTemperatureForecast.swift
//  DataLayer
//
//  Created by Lubarda, Miso on 8/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer

public class OWMTemperatureForecast: TemperatureForecastProvider {
    private let webService: WebService

    public init() {
        self.webService = WebService(session: DataNetworkSession())
    }

    public func fetch(forCity city: String, unit: TemperatureUnit, completion: @escaping (Response<TemperatureForecast>) -> Void) {
        guard let request = Request(endpoint: .temperatureForecast(city: city, unit: unit)).urlRequest else { return }
        webService.execute(request, callback: completion)
    }
}
