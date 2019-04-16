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
        guard let url = self.loadFromBundle(withName: "launches", extensionValue: "json"),
            let data = try? Data(contentsOf: url, options: .alwaysMapped) else {
            completionHandler(.failure(APIError.missingData))
            return
        }
        
        do {
            let launches = try JSONDecoder().decode([Launch].self, from: data)
            completionHandler(.success(launches))
        } catch {
            completionHandler(.failure(APIError.serializationFailed))
        }
    }
    
    // MARK: - Private Section -
    private func loadFromBundle(withName name: String, extensionValue: String) -> URL? {
        let bundle = Bundle(for: LaunchesServiceTests.self)
        let url = bundle.url(forResource: name, withExtension: extensionValue)
        return url
    }
}
