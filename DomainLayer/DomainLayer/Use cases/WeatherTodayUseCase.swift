//
//  CurrentWeatherUseCase.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

public class WeatherTodayUseCase {
    private let weatherProvider: WeatherProvider
    private let uvIndexProvider: UvIndexProvider

    public init(weatherProvider: WeatherProvider, uvIndexProvider: UvIndexProvider) {
        self.weatherProvider = weatherProvider
        self.uvIndexProvider = uvIndexProvider
    }

    public func execute(city: String, completion: @escaping (Response<WeatherToday>) -> Void) {
        weatherProvider.fetch(forCity: city, unit: .metric) { response in
            switch response {
            case let .success(currentWeather):
                self.fetchUvIndex(currentWeather: currentWeather, completion: completion)
            case let .error(error):
                completion(.error(error))
            }
        }
    }

    private func fetchUvIndex(currentWeather: CurrentWeather, completion: @escaping (Response<WeatherToday>) -> Void) {
        self.uvIndexProvider.fetch(for: currentWeather.coordinate) { response in
            switch response {
            case let .success(currentUvIndex):
                let weatherToday = WeatherTodayAdapter.getWeatherToday(from: currentWeather, currentUvIndex: currentUvIndex)
                completion(.success(weatherToday))
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}
