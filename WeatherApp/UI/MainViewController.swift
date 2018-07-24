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
        let request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?appid=2d2e389480d6cef60b5aa6004c417ab2&q=\(cityName)&units=metric")!)
        let webService = WebService()
        
        webService.execute(request, callback: { response in
            switch response {
            case let .success(result):
                print(result)
                guard let main = result["main"] as? [String: Any],
                    let tempAsDouble = main["temp"] as? Double else { return }
                self.temperatureTextField.text = String(describing: tempAsDouble)
            case let .error(error):
                print(error)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(false)
    }
}



