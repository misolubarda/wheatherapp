//
//  WebServiceTests.swift
//  WeatherAppTests
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WebServiceTests: XCTestCase {
    let expectedResult = ResultFake(key: "blabla")
    var webService: WebService!
    let requestFake = URLRequest(url: URL(string: "http://www.google.com")!)

    override func setUp() {
        let sessionFake = NetworkSessionFake(resultFake: expectedResult)
        webService = WebService(session: sessionFake)
    }

    func test_execute_whenResultIsValid_returnsResultInCallback() {
        var webServiceResult: ResultFake?

        webService.execute(requestFake) { (response: Response<ResultFake>) in
            switch response {
            case let .success(result):
                webServiceResult = result
            case let .error(error):
                print(error)
            }
        }

        XCTAssertEqual(webServiceResult!, expectedResult)
    }
}
