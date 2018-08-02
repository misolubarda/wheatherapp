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
    let resultFake: ResultFake

    init(resultFake: ResultFake) {
        self.resultFake = resultFake
    }

    func perform(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let data = try! JSONEncoder().encode(resultFake)
        completionHandler(data, nil, nil)
    }
}
