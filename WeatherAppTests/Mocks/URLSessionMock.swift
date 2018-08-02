//
//  URLSessionMock.swift
//  WeatherAppTests
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    let result: ResultFake

    init(result: ResultFake) {
        self.result = result
    }

    override func resume() {
        let data = try! JSONEncoder().encode(result)
        completionHandler!(data, nil, nil)
    }
}

struct ResultFake: Codable, Equatable {
    let key: String
}
