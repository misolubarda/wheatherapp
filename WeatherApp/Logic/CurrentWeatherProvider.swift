//
//  CurrentWeatherProvider.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/26/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class CurrentWeatherProvider {
    func fetch(forCity city: String, unit: TemperatureUnit, completion: @escaping (Response<CurrentWeather>) -> Void) {
        let request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?appid=2d2e389480d6cef60b5aa6004c417ab2&q=\(city)&units=\(unit.rawValue)")!)

        WebService().execute(request) { response in
            completion(response)
        }
    }
}
