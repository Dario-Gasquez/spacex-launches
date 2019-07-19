//
//  LaunchesURLRequestFactory.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

class LaunchesURLRequestFactory: URLRequestFactory {

    func spaceXLaunchesRequest() -> URLRequest {
        var request = jsonRequest(endPoint: "launches")
        request.httpMethod = HTTPRequestMethod.get.rawValue

        return request
    }
}
