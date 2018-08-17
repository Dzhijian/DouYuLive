//
//  ZJDiscoverRankItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemW = (kScreenW - 10) / 3
private let kItemH = Adapt(150)

class ZJDiscoverRankItem: ZJBaseCollectionCell {
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = kWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ZJRankCellItem.self, forCellWithReuseIdentifier: ZJRankCellItem.identifier())
        return collectionView
    }()
    
    var rankData : [ZJAnchorRankList]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func zj_setUpAllView() {
        setUpAllView()
       
    }
}

// MARK: - 遵守协议
extension ZJDiscoverRankItem : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rankData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJRankCellItem.identifier(), for: indexPath) as! ZJRankCellItem
        item.model = self.rankData?[indexPath.item]
        return item
    }
}


// 配置 UI 视图
extension ZJDiscoverRankItem {
    
    private func setUpAllView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
