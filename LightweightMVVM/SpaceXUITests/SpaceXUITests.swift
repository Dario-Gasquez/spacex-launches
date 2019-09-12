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


    func test_ColumnModeSwitch() {
        let app = XCUIApplication()

        let collectionView = app.collectionViews.element
        // Because we are connecting to the actual SpaceX Backend, we need to wait for the collectionView to be populated with data
        XCTAssertTrue(collectionView.cells.firstMatch.waitForExistence(timeout: 10.0))

        // Switch and verify one column mode
        app.toolbars.element.buttons["OneColumn"].tap()
        let collectionViewWidth = collectionView.frame.width
        let cell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertEqual(cell.frame.width, collectionViewWidth)

        // Switch and verify two column mode
        app.toolbars.element.buttons["TwoColumn"].tap()
        XCTAssertTrue(cell.frame.width <= collectionViewWidth / 2)
    }


    func test_ShowLaunchDetailsScreen() {
        let app = XCUIApplication()

        let collectionView = app.collectionViews.element
        // Because we are connecting to the actual SpaceX Backend, we need to wait for the collectionView to be populated with data.
        XCTAssertTrue(collectionView.cells.firstMatch.waitForExistence(timeout: 10.0)) // Wait time is the max. time the test will wait until failing. If the data is retrieved before (for example after 2 seconds) then the test will continue running at that moment.

        // Verify 4th cell exists
        let fourthMissionCell = collectionView.cells.element(boundBy: 3)
        guard fourthMissionCell.exists && fourthMissionCell.staticTexts.firstMatch.label == "RatSat" else {
            XCTFail("Failed to get exptected 4th mission")
            return
        }

        // Verify mission name and number exist and retrieve them
        XCTAssertTrue(fourthMissionCell.staticTexts.firstMatch.exists)
        let missionName = fourthMissionCell.staticTexts.firstMatch.label
        XCTAssertTrue(fourthMissionCell.staticTexts.element(boundBy: 1).exists)
        let missionNumber = fourthMissionCell.staticTexts.element(boundBy: 1).label

        // Tap the 4th cell (RatSat) which corresponds to the 1st successfull launch
        fourthMissionCell.tap()

        // NOTE: Wait for the mission badge image to exist before doing the other verifications. We do this to avoid querying the values (app.staticTexts) in the previous screen (Launches) instead of the ones we want to validate (Launch Details), which would cause the test to fail. There might be a more appropriate way to do this, for example disabling animations in AppDelegate when launching in test mode?.
        XCTAssertTrue(app.images["MissionPatchImageView"].waitForExistence(timeout: 1.0))

        // Verify 'Launch Details' title
        let title = app.navigationBars.element.identifier
        XCTAssertTrue(title == "Launch Details")

        // Verify mission name and number match those in the tapped 4th cell and result is "Success"
        XCTAssertEqual(missionName, app.staticTexts.element(boundBy: 0).label)
        XCTAssertEqual(missionNumber, app.staticTexts.element(boundBy: 2).label)
        XCTAssertEqual("Success", app.staticTexts.element(boundBy: 1).label)
    }
}
