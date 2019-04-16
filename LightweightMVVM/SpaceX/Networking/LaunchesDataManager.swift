//
//  LaunchesDataManager.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

protocol LaunchesDataManager {
    func retrieveLaunches(completionHandler: @escaping (Result<[Launch]>) -> Void)
}


class RemoteLaunchesDataManager: LaunchesDataManager {
    func retrieveLaunches(completionHandler: @escaping (Result<[Launch]>) -> Void) {
        let operation = LaunchesRetrievalOperation()
        operation.completionHandler = completionHandler
        QueueManager.enqueue(operation)
    }
}
