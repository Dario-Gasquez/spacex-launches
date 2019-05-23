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
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let parallax = (layoutAttributes as? CollectionViewParallaxLayoutAttributes)?.parallax {
            missionPatchImageView.transform = parallax
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureBorder()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        missionPatchImageView.transform = .identity
        missionPatchImageView.image = nil
        missionName.text = nil
        flightNumber.text = nil
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
    
    
    private func configureBorder() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 15
    }
}
