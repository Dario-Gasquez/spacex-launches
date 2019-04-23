//
//  FakeLaunchesDataManager.swift
//  SpaceXTests
//
//  Created by Dario on 4/16/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import XCTest
@testable import SpaceX

class FakeLaunchesDataManager: LaunchesDataManager {
    func retrieveLaunches(completionHandler: @escaping (Result<[Launch]>) -> Void) {
        let launches = stubLaunchesFromBundle(fileName: "launches", withExtension: "json")
        completionHandler(.success(launches))
    }
}
