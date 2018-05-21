//
//  CollectionViewExtendLayout.swift
//  CollectionViewExtendLayout
//
//  Created by 詹瞻 on 2018/5/21.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class CollectionViewExtendLayout: UICollectionViewFlowLayout {
    
    open var seletedIndexPath = IndexPath(row: 0, section: 0)
    
    var currentItemSize = CGSize.zero
    var collectionViewWidth = CGFloat(0)
    let itemScale = CGFloat(70.0 / 100/0)
    
    override var collectionViewContentSize: CGSize {
        return super.collectionViewContentSize
    }
    
    override func prepare() {
        super.prepare()

        currentItemSize = itemSize
        collectionViewWidth = collectionView?.frame.width ?? CGFloat(0)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if self.collectionView?.numberOfItems(inSection: 0) == 0 {
            return nil
        }
        
//        let selectedAttributes = super.layoutAttributesForItem(at: seletedIndexPath)?.copy() as? UICollectionViewLayoutAttributes
//        selectedAttributes?.transform = CGAffineTransform(scaleX: itemScale * 0.9, y: itemScale * 0.9)
//
//
//        let attributes = super.layoutAttributesForElements(in: rect)
//        attributes?.forEach({ (eachAttributes: UICollectionViewLayoutAttributes) in
//            if eachAttributes.indexPath.row == seletedIndexPath.row {
//                    eachAttributes.transform = CGAffineTransform.init(scaleX: 1.42, y: 1.42)
//
//            } else if eachAttributes.indexPath.row < seletedIndexPath.row {
//
//                NSLog("left---%d", eachAttributes.indexPath.row)
//
//            } else if eachAttributes.indexPath.row > seletedIndexPath.row {
//
//                NSLog("right---%d", eachAttributes.indexPath.row)
//
//            }
//        })
        return super.layoutAttributesForElements(in: rect)
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
