//
//  LaunchDetailsView.swift
//  SpaceX
//
//  Created by Dario on 3/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

class LaunchDetailsView: UIView {


    var launchViewModel: LaunchViewModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private Section -
    /*
     let flightNumber: String
     let missionName: String
     let launchSuccess: String
     */
    @IBOutlet private weak var shipImageView: UIImageView!

    @IBOutlet private weak var missionNameLabel: UILabel!
    @IBOutlet private weak var missionResultLabel: UILabel!
    @IBOutlet private weak var flightNumberLabel: UILabel!
    @IBOutlet private weak var missionDescriptionLabel: UILabel!

    private func updateUI() {
        missionNameLabel.text = launchViewModel?.missionName
        missionResultLabel.attributedText = launchViewModel?.attributedResult
        flightNumberLabel.text = launchViewModel?.flightNumber
        missionDescriptionLabel.text = launchViewModel?.details
        shipImageView.image = launchViewModel?.missionPatchImage
    }
}
