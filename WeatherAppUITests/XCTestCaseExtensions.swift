//
//  Support.swift
//  WeatherAppUITests
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import XCTest

extension XCTestCase {
    func waitForValue(of element: XCUIElement, toBeEmpty empty: Bool) -> XCTWaiter.Result {
        let myPredicate = NSPredicate { object, dict in
            return ((object as? XCUIElement)?.value as? String)?.isEmpty == empty
        }
        let myExpectation = expectation(for: myPredicate, evaluatedWith: element)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result
    }
}
