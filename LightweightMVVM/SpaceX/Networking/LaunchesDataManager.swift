//
//  LaunchesDataManager.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

class LaunchesDataManager {
    func retrieveLaunches(completionHander: @escaping (_ result: Result<[Launch]>) -> Void) {
        let operation = LaunchesRetrievalOperation()
        operation.completionHandler = completionHander
        QueueManager.enqueue(operation)
    }
}
