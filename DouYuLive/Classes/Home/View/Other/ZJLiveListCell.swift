//
//  ZJLiveListCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kCateCollectionHeadView = "ZJCateCollectionHeadView"
class ZJLiveListCell: ZJBaseTableCell {

    lazy var collectionView : UICollectionView = {
        let layout = ZJCollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.itemSize = CGSize(width: (kScreenW - 30) / 2, height: 100)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: Adapt(45))
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 900), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = kWhite
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CELL")
        collectionView.register(ZJCateCollectionHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:kCateCollectionHeadView )
        
        return collectionView
    }()
    override func zj_setUpAllView() {
        addSubview(collectionView)
    }

}


// MARK: - collectionViewDelegate && collectionViewDatasource
extension ZJLiveListCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath)
        cell.contentView.backgroundColor = kOrange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCateCollectionHeadView, for: indexPath)
        return headerView
        
    }
    
    
}
