//
//  URLRequestFactory.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown
    case missingData
    case serializationFailed
    case invalidData
}


class URLRequestFactory {
    
    init(config: RequestConfig = RequestConfig()) {
        self.config = config
    }
    
    
    func baseRequest(endPoint: String) -> URLRequest? {
        let stringURL = "\(config.APIHost)/\(endPoint)"
        
        guard let encodedStringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedStringURL) else {
            return nil
        }
        
        return URLRequest(url:url)
    }
    
    
    func jsonRequest(endPoint: String) -> URLRequest? {
        guard var request = baseRequest(endPoint: endPoint) else { return nil }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - Private Section -
    private let config: RequestConfig
}
