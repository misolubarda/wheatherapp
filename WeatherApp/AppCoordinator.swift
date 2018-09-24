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
    private let tabVC = UITabBarController()
  

    init(dependencies: AppCoordinatorDependencies) {
        self.dependencies = dependencies
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let loadingVC = LoadingViewController(dependencies: dependencies)
        loadingVC.fetchLocation { [weak self] (response) in
            switch response {
            case .success(let location):
                self?.setupTabBar(with: location)
            case .error(let error):
                print(error)
            }
        }
        window.rootViewController = loadingVC
        window.makeKeyAndVisible()
    }
    
    private func setupTabBar(with location: UserLocation) {
        window.rootViewController = tabVC
        let currentWeatherVC = getCurrentWeatherVC(location: location)
        let weatherForecastVC = getWeatherForecastVC(location: location)
        tabVC.viewControllers = [currentWeatherVC, weatherForecastVC]
    }
    
    private func getCurrentWeatherVC(location: UserLocation?) -> MainViewController {
        let mainViewController = MainViewController(dependencies: dependencies, location: location)
        mainViewController.tabBarItem = UITabBarItem(title: "Current Weather", image: nil, selectedImage: nil)
        return mainViewController
    }
    
    private func getWeatherForecastVC(location: UserLocation) -> WeatherForecastViewController {
        let weatherVc = WeatherForecastViewController(cityName: "", dependencies: dependencies)
        weatherVc.tabBarItem = UITabBarItem(title: "Forecast Bar Chart", image: nil, selectedImage: nil)
        return weatherVc
    }
}
