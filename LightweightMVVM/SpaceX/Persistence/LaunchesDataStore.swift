//
//  LaunchesDataStore.swift
//  SpaceX
//
//  Created by Dario on 3/17/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation


final class LaunchesDataStore {

    func store(launches: [Launch]) throws {
        guard let fileURL = storageFileURL else {
            throw LaunchesDataStoreError.writeError
        }

        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        do {
            let data = try encoder.encode(launches)
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }


    func read() throws -> [Launch] {
        guard let fileURL = storageFileURL, let plistData = try? Data(contentsOf: fileURL) else {
            throw LaunchesDataStoreError.readError
        }

        guard let launches = try? PropertyListDecoder().decode([Launch].self, from: plistData) else {
            throw LaunchesDataStoreError.decodeError
        }

        return launches
    }


    // MARK: - Private Section -
    private var storageFileURL: URL? {
        let documentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask).first
        return documentsURL?.appendingPathComponent("SpaceXLaunches.plist")
    }
}


enum LaunchesDataStoreError: Error {
    case writeError
    case readError
    case decodeError
}
