//
//  Rocket.swift
//  SpaceX
//
//  Created by Dario on 4/23/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

struct Rocket: Codable {
    let rocketID: String
    let rocketName: String
    let rocketType: String
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}
