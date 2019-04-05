//
//  PirateShipCollectionViewCell.swift
//  Buccaneers
//
//  Created by Dario on 3/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

final class LaunchCollectionViewCell: UICollectionViewCell {

    var launchViewModel: LaunchViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Private Section -
    @IBOutlet private weak var missionName: UILabel!
    @IBOutlet private weak var flightNumber: UILabel!
    @IBOutlet private weak var missionPatchImageView: UIImageView!
    
    private func updateUI() {
        missionName.text = launchViewModel?.missionName
        flightNumber.text = launchViewModel?.flightNumber
        missionPatchImageView.image = launchViewModel?.missionPatchImage
    }
}
