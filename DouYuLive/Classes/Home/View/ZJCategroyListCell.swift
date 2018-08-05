
//
//  ZJCategroyListCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

//
private let ItemWH : CGFloat = kScreenW / 4

class ZJCategroyListCell: ZJBaseTableCell {
    
    // 分页控制器
    private lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        
        return pageControl
    }()
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        // 横向滚动
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = kOrange
        collectionView.dataSource = self
        collectionView.register(ZJCategoryItem.self, forCellWithReuseIdentifier:ZJCategoryItem.identifier())
        // 分页控制
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    override func zj_setUpAllView() {
        setUpAllView()
        layout.itemSize = CGSize(width: kScreenW, height: 200)
        
    }
    
}


extension ZJCategroyListCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJCategoryItem.identifier(), for: indexPath)
        cell.contentView.backgroundColor = kRed
        cell.contentView.layer.borderColor = klineColor.cgColor
        cell.contentView.layer.borderWidth = 0.5
        return cell
    }
    
    
}



// 配置 UI
extension ZJCategroyListCell {
    
    private func setUpAllView (){
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(200)
        }
        
        
    }
}
