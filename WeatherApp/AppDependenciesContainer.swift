//
//  AppDependenciesContainer.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 07/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
import DomainLayer
import DataLayer

class AppDependenciesContainter: AppCoordinatorDependencies {
    let locationProvider:UserLocationProvider =  CurrentUserLocationProvider()
    let weatherTodayUseCase: WeatherTodayUseCase = WeatherTodayUseCase(weatherProvider: CurrentWeatherProvider(), uvIndexProvider: CurrentUvIndexProvider(), weatherProviderUsingLocation: CurrentWeatherProvider())
    let forecastUseCase: Forecast5DayUseCase = Forecast5DayUseCase(provider: OWMTemperatureForecast())
}
