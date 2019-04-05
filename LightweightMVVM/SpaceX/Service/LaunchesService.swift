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
    
    init (withAPIRequest request: APIRequest<LaunchesResource>) {
        launchesRequest = request
    }

    init() {
        let shipsResouce = LaunchesResource()
        let shipsRequest = APIRequest(resource: shipsResouce)
        launchesRequest = shipsRequest
    }
    
    
    func fetchLaunches(andRun completion: @escaping ([LaunchViewModel]?) -> Void ) {
        launchesRequest?.load { launches in
            let launchesDataStore = LaunchesDataStore()
            if launches != nil {
                self.launches = launches!.compactMap({$0})
                do {
                    try launchesDataStore.store(launches: self.launches)
                } catch {
                    fatalError("Could not save launches data to disk. error: \(error.localizedDescription)")
                }
            } else {
                // if we did not get any data from the backend, try reading the cached model from disk
                do {
                    self.launches = try launchesDataStore.read()
                } catch {
                    completion(nil)
                    return
                }
            }
            
            let launchesViewModels: [LaunchViewModel] = self.launches.map { LaunchViewModel(from: $0) }
            
            completion(launchesViewModels)
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
    private var launchesRequest: APIRequest<LaunchesResource>?
    private var launches: [Launch] = []
}
