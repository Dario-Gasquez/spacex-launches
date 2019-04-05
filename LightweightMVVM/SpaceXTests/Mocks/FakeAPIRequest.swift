//
//  FakeAPIRequest.swift
//  BuccaneersTests
//
//  Created by Dario on 3/18/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import XCTest
@testable import SpaceX

class FakeAPIRequest: APIRequest<LaunchesResource> {
    typealias Resource = LaunchesResource

    override func load(andRun completion: @escaping (Resource.Model?) -> Void) {
        if let url = self.loadFromBundle(withName: "launches", extensionValue: "json") {
            let data = try? Data(contentsOf: url, options: .alwaysMapped)
            let model = self.decode(data!)
            completion(model)
        } else {
            completion(nil)
        }
    }
    
    override func decode(_ data: Data) -> Resource.Model? {
        guard let model = try? JSONDecoder().decode(Resource.Model.self, from: data) else {
            return nil
        }
        
        return model
    }
    
    // MARK: - Private Section -
    private func loadFromBundle(withName name: String, extensionValue: String) -> URL? {
        let bundle = Bundle(for: LaunchesServiceTests.self)
        let url = bundle.url(forResource: name, withExtension: extensionValue)
        return url
    }
    
}

