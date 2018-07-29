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
    
    @IBAction func submitCity(_ sender: UIButton) {
        guard let cityName = cityTextField.text else { return }

        CurrentWeatherProvider().fetch(forCity: cityName, unit: TemperatureUnit.metric) { response in
            switch response {
            case let .success(currentWeather):
                self.updateUI(with: currentWeather)
            case let .error(error):
                print(error)
            }
        }
    }

    func updateUI(with weather: CurrentWeather) {
        self.temperatureTextField.text = String(describing: weather.temperature)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(false)
    }
}



