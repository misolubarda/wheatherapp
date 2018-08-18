//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

class MainViewController: UIViewController {
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var uvIndexTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!

    private let weatherTodayUseCase: WeatherTodayUseCase

    init(weatherTodayUseCase: WeatherTodayUseCase) {
        self.weatherTodayUseCase = weatherTodayUseCase
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func submitCity(_ sender: UIButton) {
        guard let cityName = cityTextField.text else { return }

        weatherTodayUseCase.execute(city: cityName) { response in
            switch response {
            case let .success(weatherToday):
                self.updateUI(with: weatherToday)
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
