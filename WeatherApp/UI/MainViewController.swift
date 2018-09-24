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

class MainViewController: UIViewController {
    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var uvIndexTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var humidityTextField: UITextField!

    private let dependencies: MainViewControllerDependencies
    private let location: UserLocation?

    init(dependencies: MainViewControllerDependencies, location: UserLocation?) {
        self.dependencies = dependencies
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        guard let location = location else { return }
        self.dependencies.weatherTodayUseCase.execute(with: location)  { response in
            switch response {
            case .success(let weatherToday):
                self.updateUI(with: weatherToday)
            case .error(let error):
                print(error)
            }
        }
    }
    
    @IBAction func submitCity(_ sender: UIButton) {
        guard let cityName = cityTextField.text else { return }

        dependencies.weatherTodayUseCase.execute(with: cityName) { [weak self] response in
            switch response {
            case .success(let weatherToday):
                self?.updateUI(with: weatherToday)
            case .error(let error):
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
