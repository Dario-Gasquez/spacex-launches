//
//  SpaceXUITests.swift
//  SpaceXUITests
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import XCTest

class SpaceXUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        // Adding a launch arguments allows us to process the argument and do things differently when launching in testing mode
        app.launchArguments = ["testing-mode"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testColumnModeSwitch() {
        let app = XCUIApplication()

        let collectionView = app.collectionViews.element
        // Because we are not using stub data but connecting to the actual SpaceX Backend, we need to wait for the collectionView to be populated with data
        XCTAssertTrue(collectionView.cells.firstMatch.waitForExistence(timeout: 5.0))

        // Switch and verify one column mode
        app.toolbars.element.buttons["OneColumn"].tap()
        let collectionViewWidth = collectionView.frame.width
        let cell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertEqual(cell.frame.width, collectionViewWidth)

        // Switch and verify two column mode
        app.toolbars.element.buttons["TwoColumn"].tap()
        XCTAssertTrue(cell.frame.width <= collectionViewWidth / 2)

    }

}
