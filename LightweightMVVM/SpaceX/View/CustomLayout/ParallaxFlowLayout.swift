//
//  CustomFlowLayout.swift
//  SpaceX
//
//  Created by Dario on 5/18/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

final class ParallaxFlowLayout: UICollectionViewFlowLayout {

    override public class var layoutAttributesClass: AnyClass {
        return CollectionViewParallaxLayoutAttributes.self
    }
    
    
    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        // 2 colums configuration calculations
        let topInset: CGFloat = 8.0
        let bottomInset: CGFloat = 8.0
        let leftInset: CGFloat = 8.0
        let rightInset: CGFloat = 8.0
        let minInterItemSpacing: CGFloat = 10.0
        let minLineSpacing: CGFloat = 10.0
        let itemWidth = (collectionView.bounds.width - leftInset - rightInset - minInterItemSpacing) / 2.0
        let itemHeight = collectionView.bounds.height / 3.0
        
        self.itemSize = CGSize(width: itemWidth, height:  itemHeight)
        self.sectionInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
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
    let maxParallaxOffset: CGFloat = 30.0

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
