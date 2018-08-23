//
//  ZJCategoryScrollItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let itemWH : CGFloat = kScreenW / 4

class ZJCategoryScrollItem: ZJBaseCollectionCell {
    
    var dataArr : [ZJCategoryList]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = kWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZJCategoryItem.self, forCellWithReuseIdentifier: ZJCategoryItem.identifier())
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func zj_initWithView() {
        addSubview(collectionView)
    }
    
}


extension ZJCategoryScrollItem : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJCategoryItem.identifier(), for: indexPath) as! ZJCategoryItem
        cell.contentView.layer.borderColor = klineColor.cgColor
        cell.contentView.layer.borderWidth = 0.5
        cell.model = dataArr?[indexPath.row]
        return cell
    }
    
    
}
