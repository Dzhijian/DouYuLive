
//
//  ZJCategroyListCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let ItemHeight = kScreenW / 4

class ZJCategroyListCell: ZJBaseTableCell {
    
    // 分页控制器
    private lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = kRed
        pageControl.currentPageIndicatorTintColor = kOrange
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
        collectionView.backgroundColor = kWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZJCategoryScrollItem.self, forCellWithReuseIdentifier:ZJCategoryScrollItem.identifier())
        // 分页控制
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    override func zj_setUpAllView() {
        setUpAllView()
        layout.itemSize = CGSize(width: kScreenW, height: itemWH * 2.0)
        pageControl.numberOfPages = 8
    }
    
}


extension ZJCategroyListCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJCategoryScrollItem.identifier(), for: indexPath)
        cell.backgroundColor = kRed
        return cell
    }
    
    
}


extension ZJCategroyListCell : UICollectionViewDelegate {
    // pageControl 的滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
    }
}

// 配置 UI
extension ZJCategroyListCell {
    
    private func setUpAllView (){
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(ItemHeight * 2)
        }
        
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(-5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(150)
        }
        
        
    }
}
