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
    private let weatherProviderUsingLocation: WeatherProviderUsingLocation

    public init(weatherProvider: WeatherProvider, uvIndexProvider: UvIndexProvider, weatherProviderUsingLocation: WeatherProviderUsingLocation) {
        self.weatherProvider = weatherProvider
        self.uvIndexProvider = uvIndexProvider
        self.weatherProviderUsingLocation = weatherProviderUsingLocation
    }

    public func execute(with city: String, completion: @escaping (Response<WeatherToday>) -> Void) {
        weatherProvider.fetch(for: city, unit: .metric) { [weak self] response in
            switch response {
            case let .success(currentWeather):
                self?.fetchUvIndex(currentWeather: currentWeather, completion: completion)
            case let .error(error):
                completion(.error(error))
            }
        }
    }
    
    public func execute(with location: UserLocation, completion: @escaping (Response<WeatherToday>) -> Void) {
        weatherProviderUsingLocation.fetch(for: location, unit: .metric) { [weak self] response in
            switch response {
            case .success(let currentWeather):
                self?.fetchUvIndex(currentWeather: currentWeather, completion: completion)
            case .error(let error):
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
