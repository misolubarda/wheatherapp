//
//  WeatherForecastViewController.swift
//  WeatherApp
//
//  Created by Nikola Matijevic on 07/09/2018.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer
import Charts

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dependencies.forecastUseCase.execute(city: cityName) { [weak self] response in
            switch response {
            case let .success(forecast):
                self?.barChartView.data = forecast.barChartData
            case let .error(error):
                print(error)
            }
        }
    }
}

// MARK: BarChartData extension

private extension Forecast5Day {
    var barChartData: BarChartData {
        let values = self.temperatures.enumerated().map { (offset, temperature) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(offset), y: temperature)
        }
        let dataSet = BarChartDataSet(values: values, label: "Temperature")
        let data = BarChartData(dataSet: dataSet)
        return data
    }
}
