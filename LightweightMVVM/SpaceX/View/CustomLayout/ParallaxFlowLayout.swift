//
//  ParallaxFlowLayout.swift
//  SpaceX
//
//  Created by Dario on 5/18/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

final class ParallaxFlowLayout: UICollectionViewFlowLayout {
    
    public func oneColumnMode() {
        numberOfColumns = 1
    }
    
    
    public func twoColumnsMode() {
        numberOfColumns = 2
    }
    
    
    override public class var layoutAttributesClass: AnyClass {
        return CollectionViewParallaxLayoutAttributes.self
    }
    
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let insetValue: CGFloat = (numberOfColumns == 1 ? 0.0 : 8.0)
        let edgeInsets = UIEdgeInsets(top: insetValue, left: insetValue, bottom: insetValue, right: insetValue)
        let minInterItemSpacing: CGFloat = (numberOfColumns == 1 ? 0.0 : 10.0)
        let minLineSpacing: CGFloat = 10.0
        let itemHeight = collectionView.bounds.height / (1.0 + CGFloat(numberOfColumns))
        let itemWidth = (collectionView.bounds.width - edgeInsets.left - edgeInsets.right - minInterItemSpacing) / CGFloat(numberOfColumns)
        
        self.itemSize = CGSize(width: itemWidth, height:  itemHeight)
        self.sectionInset = edgeInsets
        self.minimumLineSpacing = minLineSpacing
        self.minimumInteritemSpacing = minInterItemSpacing
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        return attributes.compactMap { $0.copy() as? CollectionViewParallaxLayoutAttributes }.map(addParallaxToAttributes)
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    // MARK - Private Section -
    private let maxParallaxOffset: CGFloat = 30.0
    
    private var numberOfColumns: UInt = 2 {
        didSet {
            guard oldValue != numberOfColumns else { return }
            
            invalidateLayout()
        }
    }
    
    
    private func addParallaxToAttributes(_ attributes: CollectionViewParallaxLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        
        let halfHeight = collectionView.frame.height / 2.0
        let halfCellHeight = itemSize.height / 2.0
        let cellDistanceFromCenter = attributes.center.y - collectionView.contentOffset.y - halfHeight
        let parallaxOffset = -(maxParallaxOffset * cellDistanceFromCenter) / (halfHeight + halfCellHeight)
        let boundedParallaxOffset = min( max(-maxParallaxOffset, parallaxOffset), maxParallaxOffset)
        let translationY = CGAffineTransform(translationX: 0, y: boundedParallaxOffset)
        
        attributes.parallax = translationY
        
        return attributes
    }
}
