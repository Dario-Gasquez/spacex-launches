//
//  LaunchViewModel.swift
//  SpaceX
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import Foundation
import UIKit

struct LaunchViewModel {
    
    let flightNumber: String
    let missionName: String
    let details: String
    let launchResult: String
    var missionPatchImage: UIImage = #imageLiteral(resourceName: "NoMissionPatch") //NOTE: as an alternative this could be a Data property, to avoid UIKit coupling for reusing this class in macOS for example

    init(from launch: Launch) {
        flightNumber = NSLocalizedString("Flight nr.", comment: "Flight number") + ": " + String(launch.flightNumber)
        missionName =  launch.missionName
        details = launch.details ?? NSLocalizedString("No mission details", comment: "No mission details")
        launchSuccess = launch.launchSuccess
        if let result = launch.launchSuccess {
            launchResult = result ? NSLocalizedString("Success", comment: "Success") : NSLocalizedString("Failed", comment: "Failed")
        } else {
            launchResult = NSLocalizedString("Not launched yet", comment: "Not launched yet")
        }
    }
    
    
    var attributedResult: NSAttributedString {
        var textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        if let wasSuccesful = launchSuccess {
            textColor = wasSuccesful ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: textColor
        ]
        return NSAttributedString(string: launchResult, attributes: textAttributes)
    }
    
    // MARK: - Private Section -
    /// - note: This value is nil for missions that have not launched yet
    private let launchSuccess: Bool?
}


