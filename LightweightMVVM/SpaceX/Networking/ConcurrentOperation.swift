//
//  ConcurrentOperation.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}


class ConcurrentOperation<T>: Operation {
    typealias OperationCompletionHandler = (_ result: Result<T>) -> Void

    var completionHandler: (OperationCompletionHandler)?

    override var isReady: Bool {
        return super.isReady && state == .ready
    }

    override var isExecuting: Bool {
        return state == .executing
    }

    override var isFinished: Bool {
        return state == .finished
    }

    override func start() {
        guard !isCancelled else {
            finish()
            return
        }

        if !isExecuting {
            state = .executing
        }

        main()
    }

    override func cancel() {
        super.cancel()
        finish()
    }

    func finish() {
        if isExecuting {
            state = .finished
        }
    }

    func complete(result: Result<T>) {
        finish()

        if !isCancelled {
            completionHandler?(result)
        }
    }


    // MARK: - Private Section -

    private enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }

    private var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            willChangeValue(forKey: oldValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
    }
}
