//
//  LaunchDetailsView.swift
//  SpaceX
//
//  Created by Dario on 3/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit
import WebKit

class LaunchDetailsView: UIView {


    var launchViewModel: LaunchViewModel? {
        didSet {
            updateUI()
            loadArticle()
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

    @IBOutlet private weak var webView: WKWebView!
    
    private func updateUI() {
        missionNameLabel.text = launchViewModel?.missionName
        missionResultLabel.attributedText = launchViewModel?.attributedResult
        flightNumberLabel.text = launchViewModel?.flightNumber
        missionDescriptionLabel.text = launchViewModel?.details
        shipImageView.image = launchViewModel?.missionPatchImage
    }
    
    
    private func loadArticle() {
        let myURL = URL(string:"https://www.nasaspaceflight.com/2013/12/spacex-falcon-9-v1-1-milestone-ses-8-launch/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
