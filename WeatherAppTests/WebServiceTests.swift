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
        let sessionMock = URLSessionMock(result: expectedResult)
        webService = WebService(urlSession: sessionMock)
    }

    func test_execute_whenResultIsValid_returnsResultInCallback() {
        var webServiceResult: ResultFake?
        let resultExpectation = expectation(description: "Result")

        webService.execute(requestFake) { (response: Response<ResultFake>) in
            switch response {
            case let .success(result):
                webServiceResult = result
            case let .error(error):
                print(error)
            }
            resultExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(webServiceResult!, expectedResult)
    }
}
