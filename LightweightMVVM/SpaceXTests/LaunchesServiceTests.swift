//
//  LaunchesServiceTests.swift
//  SpaceXTests
//
//  Created by Dario on 3/18/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import XCTest
@testable import SpaceX

class LaunchesServiceTests: XCTestCase {
    
    var launchesResource: LaunchesResource!
    var fakeRequest: FakeAPIRequest!
    var launchesService: LaunchesService!
    
    override func setUp() {
        launchesResource = LaunchesResource()
        fakeRequest = FakeAPIRequest(resource: launchesResource)
        launchesService = LaunchesService(withAPIRequest: fakeRequest)

    }

    override func tearDown() {
        fakeRequest = nil
        launchesResource = nil
        launchesService = nil
    }

    
    func testLaunchesViewModelArray_IsNotNil() {
        launchesService.fetchLaunches { launches in
            XCTAssertNotNil(launches)
        }
    }


    func testLaunchesViewModelArray_CountIsRight() {
        launchesService.fetchLaunches { launches in
            XCTAssertEqual(launches!.count, 10)
        }
    }
}
