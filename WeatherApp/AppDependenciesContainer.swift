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

class AppDependenciesContainter: MainViewControllerDependencies, WeatherForecastViewControllerDependencies {
    let weatherTodayUseCase: WeatherTodayUseCase = WeatherTodayUseCase(weatherProvider: CurrentWeatherProvider(), uvIndexProvider: CurrentUvIndexProvider())
    let forecastUseCase: Forecast5DayUseCase = Forecast5DayUseCase(provider: OWMTemperatureForecast())
}
