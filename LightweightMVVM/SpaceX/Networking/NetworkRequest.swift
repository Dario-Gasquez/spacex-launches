//
//  NetworkRequest.swift
//  SpaceX
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

protocol NetworkRequest: class {
    associatedtype Model
    func load(andRun completion: @escaping (Model?) -> Void)
    func decode(_ data: Data) -> Model?
}


extension NetworkRequest {
    func load(_ url: URL, andRun completion: @escaping (Model?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let receivedData = data else {
                    completion(nil)
                    return
                }
                let model = self?.decode(receivedData)
                completion(model)
            }
            
            task.resume()
        }
    }
}
