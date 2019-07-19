//
//  Launch.swift
//  SpaceX
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation


struct Launch {
    let flightNumber: Int
    let missionName: String
    let upcoming: Bool
    let launchYear: String
    let launchDate: String //ISO 8601 formatted date
    let details: String?
    let launchSuccess: Bool?
    let rocket: Rocket
    let links: Links
}


extension Launch: Codable {
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case launchDate = "launch_date_utc"
        case launchSuccess = "launch_success"
        case upcoming
        case details
        case links
        case rocket
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        missionName = try container.decode(String.self, forKey: .missionName)
        upcoming = try container.decode(Bool.self, forKey: .upcoming)
        launchYear = try container.decode(String.self, forKey: .launchYear)
        launchDate = try container.decode(String.self, forKey: .launchDate)
        details = try container.decodeIfPresent(String.self, forKey: .details)
        launchSuccess = try container.decodeIfPresent(Bool.self, forKey: .launchSuccess)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
        links = try container.decode(Links.self, forKey: .links)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(flightNumber, forKey: .flightNumber)
        try container.encode(missionName, forKey: .missionName)
        try container.encode(upcoming, forKey: .upcoming)
        try container.encode(launchYear, forKey: .launchYear)
        try container.encode(launchDate, forKey: .launchDate)
        try container.encodeIfPresent(details, forKey: .details)
        try container.encodeIfPresent(launchSuccess, forKey: .launchSuccess)
        try container.encode(rocket, forKey: .rocket)
        try container.encode(links, forKey: .links)
    }
}
