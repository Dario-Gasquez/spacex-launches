//
//  APIResources.swift
//  SpaceX
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

protocol APIResource {
    associatedtype Model: Codable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        // https://api.spacexdata.com/v3/launches
        let baseURL = "https://api.spacexdata.com/v3"
        let url = baseURL + methodPath
        return URL(string: url)!
    }


    func makeModel(data: Data) -> Model? {
        guard let model = try? JSONDecoder().decode(Model.self, from: data) else {
            return nil
        }
        
        return model
    }
}


struct LaunchesResource: APIResource {
    typealias Model = [Launch]
    let methodPath = "/launches"
}
