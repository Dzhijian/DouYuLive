//
//  ZJLiveListCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
private let kItemW = (kScreenW - 10) / 2
private let kItemH = kItemW * 6 / 7
private let kCateCollectionHeadView = "ZJCateCollectionHeadView"
class ZJLiveListCell: ZJBaseTableCell {

    lazy var collectionView : UICollectionView = {
        let layout = ZJCollectionViewFlowLayout()
//        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: Adapt(45))
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kContentHeight), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = kWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZJLiveListItem.self, forCellWithReuseIdentifier: ZJLiveListItem.identifier())
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCateCollectionHeadView, for: indexPath)
        return headerView
        
    }
 
}
