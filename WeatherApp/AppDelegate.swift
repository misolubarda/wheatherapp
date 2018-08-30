//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer
import DataLayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let weatherUseCase = WeatherTodayUseCase(weatherProvider: CurrentWeatherProvider(), uvIndexProvider: CurrentUvIndexProvider())
        let forecastUseCase = Forecast5DayUseCase(provider: OWMTemperatureForecast())
        let mainViewController = MainViewController(weatherTodayUseCase: weatherUseCase, forecastUseCase: forecastUseCase)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()

        return true
    }
}

