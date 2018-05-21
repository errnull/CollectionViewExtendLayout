//
//  CollectionViewExtendLayout.swift
//  CollectionViewExtendLayout
//
//  Created by 詹瞻 on 2018/5/21.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class CollectionViewExtendLayout: UICollectionViewFlowLayout {
    
    var seletedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var lastSeletedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    var totalMoreX = 0
    let cellMoveX = 4
    
    override var collectionViewContentSize: CGSize {
        
        var collectionViewSize = super.collectionViewContentSize
        collectionViewSize.width += CGFloat(cellMoveX * 2)
        
        return collectionViewSize
    }
    
    override func prepare() {
        super.prepare()
        
        guard let editorCollection = collectionView else { return }
        
        layoutAttributes = []
        let section = 0
        let numberOfItems = editorCollection.numberOfItems(inSection: section)
        for item in 0...(numberOfItems - 1) {
            
            let copyAttributes = super.layoutAttributesForItem(at: IndexPath(row: item, section: section))?.copy() as! UICollectionViewLayoutAttributes
            let cellPadding = (collectionView!.frame.size.height - copyAttributes.size.height) * 0.5
            //            copyAttributes.transform = CGAffineTransform(translationX: 0, y: cellPadding)
            
            layoutAttributes.append(copyAttributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if collectionView?.numberOfItems(inSection: 0) == 0 {
            return nil;
        }
        
        var baseLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        if seletedIndexPath.row > lastSeletedIndexPath.row {
            
            totalMoreX -= cellMoveX
            
        } else if seletedIndexPath.row < lastSeletedIndexPath.row {
            
            totalMoreX += cellMoveX
        }
        
        layoutAttributes.forEach { (attributes) in
            
            let copyAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
            
            if copyAttributes.indexPath == self.seletedIndexPath {
                
                copyAttributes.transform = CGAffineTransform.identity
                
                let cellHeight = collectionView!.bounds.height
                copyAttributes.size = CGSize(width: CGFloat(160.0 / 214.0) * cellHeight, height: cellHeight)
                
                var newFrame = copyAttributes.frame
                newFrame.origin.x -= CGFloat(totalMoreX)
                
                copyAttributes.frame = newFrame
                
                lastSeletedIndexPath = seletedIndexPath
                
                //                var contentInset = collectionView?.contentInset
                //                contentInset?.left = CGFloat(totalMoreX)
                //
                //                collectionView?.contentInset = contentInset!
                
            } else if copyAttributes.indexPath.row < self.seletedIndexPath.row {
                
                var newFrame = copyAttributes.frame
                newFrame.origin.x = newFrame.origin.x - CGFloat(totalMoreX + cellMoveX)
                
                copyAttributes.frame = newFrame
                
            } else {
                
                var newFrame = copyAttributes.frame
                newFrame.origin.x += CGFloat(-1 * totalMoreX + cellMoveX)
                
                copyAttributes.frame = newFrame
            }
            
            baseLayoutAttributes.append(copyAttributes)
            
        }
        
        return baseLayoutAttributes
    }
    
}

extension UICollectionView {
    func expandItemAtIndexPath(indexPath: IndexPath, animated: Bool) {
        let layout: CollectionViewExtendLayout = self.collectionViewLayout as! CollectionViewExtendLayout
        if animated {
            
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 16.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.performBatchUpdates({
                    
                    layout.seletedIndexPath = indexPath
                    
                }, completion: { (finished: Bool) in
                })
            }, completion: { (finished: Bool) in
            })
        } else {
            layout.seletedIndexPath = indexPath
            layout.invalidateLayout()
        }
    }
}
