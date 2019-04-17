//
//  RequestConfig.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


class RequestConfig {
    let APIHost: String
    
    init() {
        self.APIHost = "https://api.spacexdata.com/v3"
    }
}
