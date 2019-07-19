//
//  Links.swift
//  SpaceX
//
//  Created by Dario on 4/23/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation

/*
"links": {
    "mission_patch": null,
    "mission_patch_small": null,
    "reddit_campaign": null,
    "reddit_launch": null,
    "reddit_recovery": null,
    "reddit_media": null,
    "presskit": null,
    "article_link": null,
    "wikipedia": null,
    "video_link": null,
    "youtube_id": null,
    "flickr_images": []
}
*/
struct Links: Codable {
    let missionPatch: URL?
    let smallMissionPatch: URL?
    let redditCampaign: URL?
    let redditLaunch: URL?
    let redditRecovery: URL?
    let redditMedia: URL?
    let presskit: URL?
    let articleLink: URL?
    let wikipedia: URL?
    let videoLink: URL?
    let youTubeID: URL?
    let flickrImages: [URL]

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case smallMissionPatch = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youTubeID = "youtube_id"
        case flickrImages = "flickr_images"
    }
}
