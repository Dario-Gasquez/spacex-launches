//
//  LaunchesService.swift
//  SpaceX
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

/// Provides the following services:
/// - Space X launches data fetch and view model creation
/// - Launch mission patch image download
final class LaunchesService {
    
    init(launchesDataManager: LaunchesDataManager = RemoteLaunchesDataManager()) {
        self.launchesDataManager = launchesDataManager
    }

    
    func fetchLaunches(completionHandler: @escaping (_ result: Result<[LaunchViewModel]>) -> Void) {
        launchesDataManager.retrieveLaunches { (result) in
            let launchesDataStore = LaunchesDataStore()
            switch result {
            case .failure:
                // If we did not get any data from the backend, try reading the cached model from disk
                do {
                    self.launches = try launchesDataStore.read()
                } catch {
                    completionHandler(.failure(error))
                }
            case .success(let launches):
                self.launches = launches.compactMap({ $0 })
                do {
                    try launchesDataStore.store(launches: launches)
                } catch {
                    fatalError("Could nto save launches data to disk. Error: \(error.localizedDescription)")
                }
                let launchesViewModels = self.launches.map { LaunchViewModel(from: $0) }
                completionHandler(.success(launchesViewModels))
            }
        }
    }
    
    
    func fetchMissionPatchImage(at position: Int, completion: @escaping (LaunchViewModel?)->Void ) {
        guard position < launches.count else {
            assertionFailure("launches access out of bound")
            return
        }
        
        guard let url = launches[position].missionPatchImageURL else { return }
        
        let kfOptions: KingfisherOptionsInfo = [
            .processor(DownsamplingImageProcessor(size: UIScreen.main.bounds.size)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
        ]
        
        KingfisherManager.shared.retrieveImage(with: url, options: kfOptions) { result in
            switch result {
            case .success(let value):
                
                var launchViewModel = LaunchViewModel(from: self.launches[position])
                launchViewModel.missionPatchImage = value.image
                
                completion(launchViewModel)
            case .failure:
                completion(nil)
            }
        }
    }
    
    // MARK: - Private Section -
    private var launchesDataManager: LaunchesDataManager
    private var launches: [Launch] = []
}
