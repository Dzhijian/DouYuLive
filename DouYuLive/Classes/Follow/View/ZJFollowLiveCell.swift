//
//  ZJFollowLiveCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemW = (kScreenW - 5) / 2
private let kItemH = kItemW * 9 / 16 + Adapt(30)

class ZJFollowLiveCell: ZJBaseTableCell {

    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = kWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZJLiveListItem.self, forCellWithReuseIdentifier: ZJLiveListItem.identifier())
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func zj_setUpAllView() {
        setUpAllView()
    }
    
}

// MARK: - 遵守协议
extension ZJFollowLiveCell : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath) as! ZJLiveListItem
        item.descLab.isHidden = true
        return item
    }
}

// MARK: - 配置 UI
extension ZJFollowLiveCell {
    
    private func setUpAllView() {
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
