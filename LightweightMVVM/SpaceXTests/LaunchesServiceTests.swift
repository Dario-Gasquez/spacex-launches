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
    
    var launchesService: LaunchesService!
    
    override func setUp() {
        launchesService = LaunchesService(launchesDataManager: FakeLaunchesDataManager())

    }

    override func tearDown() {
        launchesService = nil
    }

    
    func testLaunchesViewModelArray_IsNotEmpty() {
        launchesService.fetchLaunches { (result) in
            switch result {
            case .failure:
                XCTFail("received .failure instead of .success")
            case .success(let launches):
                XCTAssert(!launches.isEmpty, "expected non emtpy launches array")
            }
        }
    }


    func testLaunchesViewModelArray_CountIsRight() {
        launchesService.fetchLaunches { (result) in
            if case .success(let launches) = result {
                XCTAssertEqual(launches.count, 10)
            } else {
                XCTFail("received .failure instead of .success")
            }
        }
    }
}
