//
//  APIRequest.swift
//  SpaceX
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation


class APIRequest<Resource: APIResource>: NetworkRequest {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }

    func decode(_ data: Data) -> Resource.Model? {
        return resource.makeModel(data: data)
    }
    
    func load(andRun completion: @escaping (Resource.Model?) -> Void) {
        load(resource.url, andRun: completion)
    }
}

