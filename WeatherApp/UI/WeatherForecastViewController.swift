//
//  WeatherForecastViewController.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 07/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol WeatherForecastViewControllerDependencies {
    var forecastUseCase: Forecast5DayUseCase { get }
}

class WeatherForecastViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    
    private let dependencies: WeatherForecastViewControllerDependencies
    private let cityName: String

    init(cityName: String, dependencies: WeatherForecastViewControllerDependencies) {
        self.dependencies = dependencies
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dependencies.forecastUseCase.execute(city: cityName) { [weak self] response in
            switch response {
            case let .success(forecast):
                self?.barChartView.update(with: forecast.temperatures)
            case let .error(error):
                print(error)
            }
        }
    }
}
