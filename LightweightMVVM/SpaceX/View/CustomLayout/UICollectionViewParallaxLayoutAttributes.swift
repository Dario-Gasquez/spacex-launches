//
//  UICollectionViewParallaxLayoutAttributes.swift
//  SpaceX
//
//  Created by Dario on 5/20/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

final class CollectionViewParallaxLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // MARK: - Properties
    var parallax: CGAffineTransform = .identity
    
    // MARK: - Life Cycle
    override func copy(with zone: NSZone?) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? CollectionViewParallaxLayoutAttributes else {
            return super.copy(with: zone)
        }
        
        copiedAttributes.parallax = parallax
        return copiedAttributes
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? CollectionViewParallaxLayoutAttributes else {
            return false
        }
        
        if NSValue(cgAffineTransform: otherAttributes.parallax) != NSValue(cgAffineTransform: parallax) {
            return false
        }
        
        return super.isEqual(object)
    }
}
