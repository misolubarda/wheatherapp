//
//  WebServiceTests.swift
//  WeatherAppTests
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
@testable import DataLayer
import DomainLayer

class WebServiceTests: XCTestCase {
    let expectedResult = ResultFake(key: "blabla")
    var webService: WebService!
    let requestFake = URLRequest(url: URL(string: "http://www.google.com")!)

    override func setUp() {
        let sessionFake = NetworkSessionFake(resultFake: expectedResult, error: nil)
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

    func test_execute_whenResultIsError_returnsErrorInCallback() {
        let expectedError = NSError(domain: NSURLErrorDomain, code: 400, userInfo: nil)
        let sessionFake = NetworkSessionFake(resultFake: nil, error: expectedError)
        webService = WebService(session: sessionFake)

        var webServiceError: NSError?
        webService.execute(requestFake) { (response: Response<ResultFake>) in
            switch response {
            case .success:
                break
            case let .error(error as NSError):
                webServiceError = error
            }
        }

        XCTAssertEqual(webServiceError, expectedError)
    }

    func test_execute_whenResultIsDataAndError_returnsErrorInCallback() {
        let expectedError = NSError(domain: NSURLErrorDomain, code: 400, userInfo: nil)
        let sessionFake = NetworkSessionFake(resultFake: expectedResult, error: expectedError)
        webService = WebService(session: sessionFake)

        var webServiceError: NSError?
        webService.execute(requestFake) { (response: Response<ResultFake>) in
            switch response {
            case .success:
                break
            case let .error(error as NSError):
                webServiceError = error
            }
        }

        XCTAssertEqual(webServiceError, expectedError)
    }
}
