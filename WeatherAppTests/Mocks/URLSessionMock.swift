//
//  URLSessionMock.swift
//  WeatherAppTests
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    let result: ResultFake

    init(result: ResultFake) {
        self.result = result
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let dataTaskMock = URLSessionDataTaskMock(result: result)
        dataTaskMock.completionHandler = completionHandler
        return dataTaskMock
    }
}

private class URLSessionDataTaskMock: URLSessionDataTask {
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
