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
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!


    @IBAction func submitCity(_ sender: UIButton) {
        guard let cityName = cityTextField.text else { return }

        WeatherTodayUseCase.execute(city: cityName) { response in
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
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(false)
    }
}
