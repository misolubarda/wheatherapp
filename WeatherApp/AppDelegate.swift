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
        let useCase = WeatherTodayUseCase(weatherProvider: CurrentWeatherProvider(), uvIndexProvider: CurrentUvIndexProvider())
        let mainViewController = MainViewController(weatherTodayUseCase: useCase)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()

        return true
    }
}

