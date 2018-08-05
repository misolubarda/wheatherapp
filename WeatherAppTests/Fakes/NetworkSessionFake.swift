//
//  NetworkSessionFake.swift
//  WeatherAppTests
//
//  Created by Lubarda, Miso on 8/2/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation
@testable import WeatherApp

class NetworkSessionFake: NetworkSession {
    let resultFake: ResultFake?
    let error: Error?

    init(resultFake: ResultFake?, error: Error?) {
        self.resultFake = resultFake
        self.error = error
    }

    func perform(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let data = try? JSONEncoder().encode(resultFake)
        completionHandler(data, nil, error)
    }
}
