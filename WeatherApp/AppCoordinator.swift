//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 07/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol AppCoordinatorDependencies: MainViewControllerDependencies, WeatherForecastViewControllerDependencies, LoadingViewControllerDependencies{
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
        let loadingVC = LoadingViewController(dependencies: dependencies)
        loadingVC.fetchLocation { [weak self] (response) in
            switch response {
            case .success(let location):
                self?.openCurrentWeatherVC(location: location)
            case .error(let error):
                self?.openCurrentWeatherVC(location: nil)
                print(error)
            }
        }
        window.rootViewController = navVC
        navVC.viewControllers = [loadingVC]
        window.makeKeyAndVisible()
    }
    
    private func openCurrentWeatherVC(location: UserLocation?) {
        let mainViewController = MainViewController(dependencies: dependencies, location: location)
        mainViewController.delegate = self
        navVC.viewControllers = [mainViewController]
    }
    
    private func openWeatherForecast(cityName: String) {
        let weatherVc = WeatherForecastViewController(cityName: cityName, dependencies: dependencies)
        navVC.pushViewController(weatherVc, animated: true)
    }
}

extension AppCoordinator: MainViewControllerDelegate {
    func mainViewControllerDidTapShowForecast(cityName: String) {
        openWeatherForecast(cityName: cityName)
    }
}
