//
//  LaunchesRetrievalOperation.swift
//  SpaceX
//
//  Created by Dario on 4/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

class LaunchesRetrievalOperation: ConcurrentOperation<[Launch]> {
    
    init(session: URLSession = URLSession.shared, launchesRequestFactory: LaunchesURLRequestFactory = LaunchesURLRequestFactory()) {
        self.session = session
        self.launchesRequestFactory = launchesRequestFactory
    }
    
    
    override func main() {
        let urlRequest = launchesRequestFactory.spaceXLaunchesRequest()
        
        task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let launchesData = data else {
                DispatchQueue.main.async {
                    if let requestError = error { self.complete(result: .failure(requestError)) }
                    else { self.complete(result: .failure(APIError.missingData)) }
                }
                return
            }
            
            do {
                let launches = try JSONDecoder().decode([Launch].self, from: launchesData)
                DispatchQueue.main.async {
                    self.complete(result: .success(launches))
                }
            } catch {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self.complete(result: .failure(APIError.serializationFailed))
                }
            }
        })
        task?.resume()
    }
    
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    // MARK: - Private Section -
    private let session: URLSession
    private let launchesRequestFactory: LaunchesURLRequestFactory
    private var task: URLSessionTask?
}
