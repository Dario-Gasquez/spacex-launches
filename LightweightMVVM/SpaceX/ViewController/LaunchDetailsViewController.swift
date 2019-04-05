//
//  LaunchDetailsViewController.swift
//  SpaceX

//
//  Created by Dario on 3/15/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

class LaunchDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Launch Details", comment: "Launch Details screen title")
        launchDetailsView.launchViewModel = launchViewModel
    }
    
    var launchViewModel: LaunchViewModel?

    // MARK: - Private Section -
    @IBOutlet private var launchDetailsView: LaunchDetailsView!
}
