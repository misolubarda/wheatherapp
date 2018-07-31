//
//  EndpointTests.swift
//  WeatherAppTests
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest
@testable import WeatherApp

class EndpointTests: XCTestCase {
    func test_path_whenCurrentWeather_returnsWeather() {
        let currentWeatherEndpoint = Endpoint.currentWeather(city: "someCity", unit: .metric)

        XCTAssertEqual(currentWeatherEndpoint.path, "weather")
    }

    func test_path_whenCurrentUvIndex_returnsUvi() {
        let currentUvIndexEndpoint = Endpoint.currentUvIndex(coordinate: Coordinate(lat: 0, long: 0))

        XCTAssertEqual(currentUvIndexEndpoint.path, "uvi")
    }

    func test_inputParameters_whenCurrentWeather_returnsCorrectResult() {
        let currentWeatherEndpoint = Endpoint.currentWeather(city: "someCity", unit: .metric)

        XCTAssertEqual(currentWeatherEndpoint.inputParameters, "&q=someCity&units=metric")
    }

    func test_inputParameters_whenCurrentUvIndex_returnsCorrectResult() {
        let currentUvIndexEndpoint = Endpoint.currentUvIndex(coordinate: Coordinate(lat: 10.22, long: 20.45))

        XCTAssertEqual(currentUvIndexEndpoint.inputParameters, "&lat=10.22&lon=20.45")
    }
}
