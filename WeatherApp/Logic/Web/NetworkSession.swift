//
//  NetworkSession.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 8/2/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}
