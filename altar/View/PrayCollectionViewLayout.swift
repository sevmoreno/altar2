//
//  PrayCollectionViewLayout.swift
//  altar
//
//  Created by Juan Moreno on 11/20/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//
/*
import UIKit

class PrayCollectionViewLayout: UICollectionViewLayout {
    
    // https://www.raywenderlich.com/4829472-uicollectionview-custom-layout-tutorial-pinterest
    
    // 1
   // weak var delegate: PinterestLayoutDelegate?
    
    // 2
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    
    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 4
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        // 1
        guard
            cache.isEmpty,
            let collectionView = collectionView
            else {
                return
        }
        // 2
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let photoHeight = delegate?.collectionView(
                collectionView,
                heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
        
        
        func layoutAttributesForElements(in rect: CGRect)
            -> [UICollectionViewLayoutAttributes]? {
                var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
                
                // Loop through the cache and look for items in the rect
                for attributes in cache {
                    if attributes.frame.intersects(rect) {
                        visibleLayoutAttributes.append(attributes)
                    }
                }
                return visibleLayoutAttributes
        }
        
        func layoutAttributesForItem(at indexPath: IndexPath)
            -> UICollectionViewLayoutAttributes? {
                return cache[indexPath.item]
        }

}
    
    
    /* THE CHINO CODE
    var numberOfColums: CGFloat = 2
    var cellPading: CGFloat = 5.0
    private var contentHight: CGFloat = 0.0  // Altura de toda la tabla
   
    private var contentWidth: CGFloat {  // Que sea del tamanao de la pantalla.
        
        let insents = collectionView!.contentInset
        
        return (collectionView!.bounds.width - (insents.left + insents.right))
    }
    
    private var attributeCatch = [UICollectionViewLayoutAttributes] ()
    
    
    
    override func prepare() {
        // when the layout change call this method
        if attributeCatch.isEmpty {
            
            
            
        }
        
    }
 
 */
    

}

 */

/*

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}
*/
