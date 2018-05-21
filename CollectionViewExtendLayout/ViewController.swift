//
//  ViewController.swift
//  CollectionViewExtendLayout
//
//  Created by Loong on 2018/5/20.
//  Copyright © 2018年 Errnull. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let cellIdentifier = "Cell"
    var collectionView: UICollectionView?
    let itemSize = CGSize(width: 70, height: 100)
    let itemScale = CGFloat(70.0 / 100/0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        
        let collectionViewHeight = CGFloat(150)
        let layout = CollectionViewExtendLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
//        layout.estimatedItemSize = CGSize(width: 70, height: 100)
//        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height - collectionViewHeight - 20, width: view.frame.width, height: collectionViewHeight), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: collectionViewHeight - 1, left: -1 * (itemSize.width / itemScale - itemSize.width) * 0.5, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }
    
    // MARK: UICollectionViewDelegate, UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        cell.backgroundColor = UIColor.red
        cell.label.text = String(format: "%d", indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("%d", indexPath.row)
        collectionView.expandItemAtIndexPath(indexPath: indexPath, animated: true)
    }
}

