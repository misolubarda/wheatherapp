//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol MainViewControllerDependencies {
    var weatherTodayUseCase: WeatherTodayUseCase { get }
}

protocol MainViewControllerDelegate: class {
    func mainViewControllerDidTapShowForecast(cityName: String)
}

class MainViewController: UIViewController {
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var uvIndexTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!

    private let dependencies: MainViewControllerDependencies
    weak var delegate: MainViewControllerDelegate?

    init(dependencies: MainViewControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    @IBAction func showForecast(_ sender: UIButton) {
        guard let cityName = cityTextField.text, !cityName.isEmpty else { return }
        delegate?.mainViewControllerDidTapShowForecast(cityName: cityName)
    }
    
    @IBAction func submitCity(_ sender: UIButton) {
        guard let cityName = cityTextField.text else { return }

        dependencies.weatherTodayUseCase.execute(city: cityName) { [weak self] response in
            switch response {
            case let .success(weatherToday):
                self?.updateUI(with: weatherToday)
            case let .error(error):
                print(error)
            }
        }

    }

    func updateUI(with weatherToday: WeatherToday) {
        self.temperatureTextField.text = String(describing: weatherToday.temperature)
        self.uvIndexTextField.text = String(describing: weatherToday.uvIndex)
        self.humidityTextField.text = String(describing: weatherToday.humidity)
        self.minTempTextField.text = String(describing: weatherToday.minTemp)
        self.maxTempTextField.text = String(describing: weatherToday.maxTemp)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(false)
    }
}
