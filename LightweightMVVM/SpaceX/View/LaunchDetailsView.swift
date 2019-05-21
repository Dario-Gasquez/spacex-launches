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
    @IBOutlet private weak var webViewHeightConstraint: NSLayoutConstraint!
    
    private func updateUI() {
        missionNameLabel.text = launchViewModel?.missionName
        missionResultLabel.attributedText = launchViewModel?.attributedResult
        flightNumberLabel.text = launchViewModel?.flightNumber
        missionDescriptionLabel.text = launchViewModel?.details
        shipImageView.image = launchViewModel?.missionPatchImage
    }
    
    
    private func loadArticle() {
        guard let articleURL = launchViewModel?.articleURL else {
            // Hiding the webView is not enough. As we are using AutoLayout reducing the height constraint is needed in order to avoid having an empty, scrollable space.
            webViewHeightConstraint.constant = 0
            return
        }
        
        let myRequest = URLRequest(url: articleURL)
        webView.load(myRequest)
    }
}
