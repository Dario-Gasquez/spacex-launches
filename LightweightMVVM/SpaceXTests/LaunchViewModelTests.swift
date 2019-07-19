//
//  LaunchViewModelTests.swift
//  SpaceXTests
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import XCTest
@testable import SpaceX

class LaunchViewModelTests: XCTestCase {
    var launches: [Launch]!

    override func setUp() {
        launches = stubLaunchesFromBundle(fileName: "launches", withExtension: "json")
    }

    override func tearDown() {
        launches = nil
    }


    func test_Valid_Initalization() {
        let launch = launches.first!

        let launchViewModel = LaunchViewModel(from: launch)

        let expectedFlightNumberString = NSLocalizedString("Flight nr.", comment: "Flight number") + ": " + String(launch.flightNumber)
        XCTAssertEqual(launchViewModel.flightNumber, expectedFlightNumberString)
        XCTAssertEqual(launchViewModel.details, launch.details)
        XCTAssertEqual(launchViewModel.missionName, launch.missionName)
        XCTAssertEqual(launchViewModel.launchResult, NSLocalizedString("Failed", comment: "Failed"))
        XCTAssertEqual(launchViewModel.missionPatchImage, UIImage(named: "NoMissionPatch"))
        XCTAssertEqual(launchViewModel.articleURL, launch.links.articleLink)
    }


    func test_Nil_Details() {
        let launch = launches.last!
        let launchViewModel = LaunchViewModel(from: launch)

        let expectedDetails =  NSLocalizedString("No mission details", comment: "No mission details")
        XCTAssertEqual(launchViewModel.details, expectedDetails)
    }


    func test_Nil_LaunchSuccess() {
        let launch = launches.last!
        let expectedLaunchResult =  NSLocalizedString("Not launched yet", comment: "Not launched yet")

        testLaunchHelper(expectedLaunchResult: expectedLaunchResult, launch: launch)
    }


    func test_LaunchSucceeded() {
        let launch = launches[5]
        let expectedLaunchResult =  NSLocalizedString("Success", comment: "Success")

        testLaunchHelper(expectedLaunchResult: expectedLaunchResult, launch: launch)
    }


    // MARK: - Private section -
    private func testLaunchHelper(expectedLaunchResult: String, launch: Launch) {
        let launchViewModel = LaunchViewModel(from: launch)
        XCTAssertEqual(launchViewModel.launchResult, expectedLaunchResult)
    }
}
