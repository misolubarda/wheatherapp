//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Lubarda, Miso on 7/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest

class WeatherAppUITests: XCTestCase {
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func test_getWeatherInfo() {
        let app = XCUIApplication()
        let cityTextField = app.textFields.matching(identifier: "cityTextField").element(boundBy: 0)
        cityTextField.tap()
        cityTextField.typeText("podgorica")
        app.buttons["Submit"].tap()

        let temperatureTextField = app.textFields.matching(identifier: "temperatureTextField").element(boundBy: 0)

        let result = waitForValue(of: temperatureTextField, toBeEmpty: false)

        XCTAssertTrue(result == .completed)
    }
}
