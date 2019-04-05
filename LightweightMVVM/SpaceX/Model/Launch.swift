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
    let details: String?
    let launchSuccess: Bool?
    let missionPatchImageURL: URL?
}

extension Launch: Codable {
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchSuccess = "launch_success"
        case details
        case links
        
        enum LinksKeys: String, CodingKey {
            case missionPatchImageURL = "mission_patch"
        }
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        missionName = try container.decode(String.self, forKey: .missionName)
        details = try container.decodeIfPresent(String.self, forKey: .details)
        launchSuccess = try container.decodeIfPresent(Bool.self, forKey: .launchSuccess)
        
        let linksContainer = try container.nestedContainer(keyedBy: CodingKeys.LinksKeys.self, forKey: .links)
        missionPatchImageURL = try linksContainer.decodeIfPresent(URL.self, forKey: .missionPatchImageURL)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(flightNumber, forKey: .flightNumber)
        try container.encode(missionName, forKey: .missionName)
        try container.encodeIfPresent(details, forKey: .details)
        
        var linksContainer = container.nestedContainer(keyedBy: CodingKeys.LinksKeys.self, forKey: .links)
        try linksContainer.encodeIfPresent(missionPatchImageURL, forKey: .missionPatchImageURL)
    }
}
