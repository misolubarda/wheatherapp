//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var uvIndexTextField: UITextField!
    
    @IBAction func submitCity(_ sender: UIButton) {
        guard let cityName = cityTextField.text else { return }

        CurrentWeatherProvider().fetch(forCity: cityName, unit: TemperatureUnit.metric) { response in
            switch response {
            case let .success(currentWeather):
                CurrentUvIndexProvider().fetch(for: currentWeather.coordinate) { response in
                    switch response {
                    case let .success(currentUvIndex):
                        self.updateUI(with: currentWeather, uvIndex: currentUvIndex)
                    case let .error(error):
                        print(error)
                    }
                }
            case let .error(error):
                print(error)
            }
        }
    }

    func updateUI(with weather: CurrentWeather, uvIndex: CurrentUvIndex) {
        self.temperatureTextField.text = String(describing: weather.temperature)
        self.uvIndexTextField.text = String(describing: uvIndex.value)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(false)
    }
}



