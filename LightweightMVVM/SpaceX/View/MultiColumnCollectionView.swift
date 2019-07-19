//
//  MultiColumnCollectionView.swift
//  SpaceX
//
//  Created by Dario on 5/23/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

class MultiColumnCollectionView: UICollectionView {

    enum Mode {
        case oneColumnMode
        case twoColumnMode
    }

    func switchTo(_ mode: Mode) {
        guard let parallaxFlowLayout = collectionViewLayout as? ParallaxFlowLayout else {
            assertionFailure("collectionViewLayout is not of the expected type: ParallaxFlowLayout")
            return
        }
        switch mode {
        case .oneColumnMode:
            parallaxFlowLayout.changeToOneColumnLayout()
        case .twoColumnMode:
            parallaxFlowLayout.changeToTwoColumnsLayout()
        }
    }
}
