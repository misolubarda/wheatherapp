//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 07/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol AppCoordinatorDependencies: MainViewControllerDependencies, WeatherForecastViewControllerDependencies {
}

class AppCoordinator {
    private let dependencies: AppCoordinatorDependencies
    private let window: UIWindow
    private let navVC = UINavigationController()
    
    init(dependencies: AppCoordinatorDependencies) {
        self.dependencies = dependencies
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let mainViewController = MainViewController(dependencies: dependencies)
        mainViewController.delegate = self
        window.rootViewController = navVC
        navVC.viewControllers = [mainViewController]
        window.makeKeyAndVisible()
    }
    
    func openWeatherForecast(cityName: String) {
        let weatherVc = WeatherForecastViewController(cityName: cityName, dependencies: dependencies)
        navVC.pushViewController(weatherVc, animated: true)
    }
}

extension AppCoordinator: MainViewControllerDelegate {
    func mainViewControllerDidTapShowForecast(cityName: String) {
        openWeatherForecast(cityName: cityName)
    }
}
