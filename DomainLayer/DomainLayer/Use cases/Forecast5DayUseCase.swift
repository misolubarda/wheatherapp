//
//  ForecastUseCase.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 8/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public class Forecast5DayUseCase {
    private let provider: TemperatureForecastProvider

    public init(provider: TemperatureForecastProvider) {
        self.provider = provider
    }

    public func execute(city: String, completion: @escaping (Response<Forecast5Day>) -> Void) {
        provider.fetch(forCity: city, unit: .metric) { response in
            switch response {
            case let .success(forecast):
                let forecastEntity = Forecast5Day(temperatures: forecast.temperatures)
                completion(.success(forecastEntity))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}
