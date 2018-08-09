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

protocol ZJChildCateSelectDelegate : class {
    func childCateSelectAction(cateId: String,index : Int)
}

// 滚动回调
typealias ScrollBlock = (Bool) -> ()
class ZJLiveListCell: ZJBaseTableCell {
    
    weak var delegate : ZJChildCateSelectDelegate?
    
    var scrollBlock : ScrollBlock?
    
    lazy var collectionView : UICollectionView = {
        let layout = ZJCollectionViewFlowLayout()
//        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: Adapt(40))
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kContentHeight), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = kWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZJLiveListItem.self, forCellWithReuseIdentifier: ZJLiveListItem.identifier())
        collectionView.register(ZJCateCollectionHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:kCateCollectionHeadView )
        
        return collectionView
    }()
    
    var liveRoomList : [ZJAllLiveList]? {
        
        didSet{
            
            self.collectionView.reloadData()
        }
    }
    
    var cateListData : [ZJChildCateList]? {
        
        didSet{
            
            self.collectionView.reloadData()
        }
    }
    override func zj_setUpAllView() {
        addSubview(collectionView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        
        if offSetY > 120 {
            if (scrollBlock != nil) {
                
                scrollBlock!(true)
            }
        }else{
            if (scrollBlock != nil) {
                scrollBlock!(false)
            }
        }
    }
}


// MARK: - collectionViewDelegate && collectionViewDatasource
extension ZJLiveListCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.liveRoomList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath) as! ZJLiveListItem
        
        cell.allModel = self.liveRoomList?[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCateCollectionHeadView, for: indexPath) as! ZJCateCollectionHeadView
        headerView.cateList = self.cateListData
        headerView.delegate = self
        return headerView
        
    }
 
}



// MARK: - ZJCateItemSelectedDelegate
extension ZJLiveListCell : ZJCateItemSelectedDelegate {
    
    func cateItemSelected(cateId: String, index: Int) {
        
        delegate?.childCateSelectAction(cateId: cateId ,index: index)
    }
    
}
