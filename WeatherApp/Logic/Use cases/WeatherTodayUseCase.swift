//
//  CurrentWeatherUseCase.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class WeatherTodayUseCase {
    static func execute(city: String, completion: @escaping (Response<WeatherToday>) -> Void) {
        CurrentWeatherProvider().fetch(forCity: city, unit: .metric) { response in
            switch response {
            case let .success(currentWeather):
                CurrentUvIndexProvider().fetch(for: currentWeather.coordinate) { response in
                    switch response {
                    case let .success(currentUvIndex):
                        let weatherToday = WeatherTodayAdapter.getWeatherToday(from: currentWeather, currentUvIndex: currentUvIndex)
                        completion(.success(weatherToday))
                    case let .error(error):
                        completion(.error(error))
                    }
                }
            case let .error(error):
                completion(.error(error))
            }
        }
    }
}
