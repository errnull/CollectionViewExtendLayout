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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        collectionView?.bounds = CGRect(x: 0, y: 0, width: 375, height: 150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        
        let collectionViewHeight = CGFloat(150)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 120, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height - collectionViewHeight, width: view.frame.width, height: collectionViewHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView)
        
        self.collectionView = collectionView
    }
    
    // MARK: UICollectionViewDelegate, UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        
        return cell
    }
}

