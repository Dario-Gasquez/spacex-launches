//
//  Utilities.swift
//  SpaceXTests
//
//  Created by Dario on 4/22/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation
@testable import SpaceX

func stubLaunchesFromBundle(fileName: String, withExtension: String) -> [Launch] {
    let bundle = Bundle(for: LaunchesServiceTests.self)
    let url = bundle.url(forResource: fileName, withExtension: withExtension)
    let data = try! Data(contentsOf: url!, options: .alwaysMapped)
    let launches = try! JSONDecoder().decode([Launch].self, from: data)

    return launches
}
