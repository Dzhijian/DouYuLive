//
//  ZJCarouselView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


public enum pageControlPosition {
    case  center
    case  left
    case  right
}





class ZJCarouselView: UIView {
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(ZJBaseCollectionCell.self, forCellWithReuseIdentifier: ZJBaseCollectionCell.identifier())
        return collectionView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

// 配置 UI 视图
extension ZJCarouselView {
    
    private func setUpAllView() {
        
    }
}

// MARK: - 遵守协议
extension ZJCarouselView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJBaseCollectionCell.identifier(), for: indexPath)
        
        return item
    }
}

