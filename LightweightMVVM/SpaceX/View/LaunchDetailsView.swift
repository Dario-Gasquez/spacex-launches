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

    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    @IBOutlet weak var webViewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var webViewHeightConstraint: NSLayoutConstraint!
    
    private func updateUI() {
        missionNameLabel.text = launchViewModel?.missionName
        missionResultLabel.attributedText = launchViewModel?.attributedResult
        flightNumberLabel.text = launchViewModel?.flightNumber
        missionDescriptionLabel.text = launchViewModel?.details
        shipImageView.image = launchViewModel?.missionPatchImage
    }
    
    
    private func loadArticle() {

        // Hide the webView until the webpage has finished loading. As we are using AutoLayout setting isHidden to true is not enough, reducing the height constraint is needed in order to avoid having an empty, scrollable space.
        webViewHeightConstraint.constant = 0

        guard let articleURL = launchViewModel?.articleURL else { return }
        
        let webArticleRequest = URLRequest(url: articleURL)
        webView.load(webArticleRequest)
        webViewActivityIndicator.startAnimating()
    }
}


extension LaunchDetailsView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewActivityIndicator.stopAnimating()
        webViewHeightConstraint.constant = 500
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webViewActivityIndicator.stopAnimating()
    }
}
