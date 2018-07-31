//
//  Request.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/29/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class Request {
    let baseUrlString = "http://api.openweathermap.org/data/2.5"
    let authParameters = "?" + "appid=2d2e389480d6cef60b5aa6004c417ab2"
    let endpoint: Endpoint

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    var urlRequest: URLRequest? {
        let urlString = baseUrlString + "/" + endpoint.path + authParameters + endpoint.inputParameters
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
}
