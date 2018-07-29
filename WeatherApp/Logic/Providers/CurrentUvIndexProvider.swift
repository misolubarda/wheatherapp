//
//  CurrentUvIndexProvider.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/29/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class CurrentUvIndexProvider {
    func fetch(for coordinate: Coordinate, completion: @escaping (Response<CurrentUvIndex>) -> Void) {
        let request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/uvi?appid=2d2e389480d6cef60b5aa6004c417ab2&lat=\(coordinate.lat)&lon=\(coordinate.long)")!)

        WebService().execute(request) { response in
            completion(response)
        }
    }
}
