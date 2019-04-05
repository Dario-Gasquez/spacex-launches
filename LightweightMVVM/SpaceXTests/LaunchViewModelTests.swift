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
    let validFlightNumber = 6
    let validMissionName = "Falcon 9 Test Flight"
    let validDetails = "Last launch of the original Falcon 9 v1.0 launch vehicle"
    let validMissionPatchImageURL = URL(string: "https://images2.imgbox.com/5c/36/gbDKf6Y7_o.png")
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    
    func test_Valid_Initalization() {
        let launch = Launch(flightNumber: validFlightNumber, missionName: validMissionName, details: validDetails, launchSuccess: true, missionPatchImageURL: validMissionPatchImageURL)
        let launchViewModel = LaunchViewModel(from: launch)
        
        let expectedFlightNumberString = NSLocalizedString("Flight nr.", comment: "Flight number") + ": " + String(validFlightNumber)
        XCTAssertEqual(launchViewModel.flightNumber, expectedFlightNumberString)
        XCTAssertEqual(launchViewModel.details, validDetails)
        XCTAssertEqual(launchViewModel.missionName, validMissionName)
        XCTAssertEqual(launchViewModel.launchResult, NSLocalizedString("Success", comment: "Success"))
        XCTAssertEqual(launchViewModel.missionPatchImage, UIImage(named: "NoMissionPatch"))
    }
    
    
    func test_Nil_Details() {
        let launch = Launch(flightNumber: validFlightNumber, missionName: validMissionName, details: nil, launchSuccess: true, missionPatchImageURL: validMissionPatchImageURL)
        let launchViewModel = LaunchViewModel(from: launch)
        
        let expectedDetails =  NSLocalizedString("No mission details", comment: "No mission details")
        XCTAssertEqual(launchViewModel.details, expectedDetails)
    }
    
    
    func test_Nil_LaunchSuccess() {
        let expectedLaunchResult =  NSLocalizedString("Not launched yet", comment: "Not launched yet")
        testLaunchResultHelper(launchSuccess: nil, expectedResult: expectedLaunchResult)
    }
    
    
    func test_LaunchFailed() {
        let expectedLaunchResult =  NSLocalizedString("Failed", comment: "Failed")

        testLaunchResultHelper(launchSuccess: false, expectedResult: expectedLaunchResult)
    }
    
    
    // MARK: - Private Section -
    private func testLaunchResultHelper(launchSuccess: Bool?, expectedResult: String) {
        let launch = Launch(flightNumber: validFlightNumber, missionName: validMissionName, details: validDetails, launchSuccess: launchSuccess, missionPatchImageURL: validMissionPatchImageURL)
        let launchViewModel = LaunchViewModel(from: launch)
        XCTAssertEqual(launchViewModel.launchResult, expectedResult)
    }
}
