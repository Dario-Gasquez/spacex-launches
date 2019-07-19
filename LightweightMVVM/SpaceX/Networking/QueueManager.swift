//
//  QueueManager.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

class QueueManager {

    static func enqueue(_ operation: Operation) {
        queue.addOperation(operation)
    }

    //MARK: - Private Section -
    private static let queue = OperationQueue()

}
