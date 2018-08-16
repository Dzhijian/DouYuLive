//
//  ZJFaceScoreCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/15.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
private let kItemW = (kScreenW - 5) / 2
private let kItemH = kItemW * 5 / 4 - Adapt(30)

class ZJFaceScoreCell: ZJBaseTableCell {
    
    var faceScoreDataList : [ZJLiveItemModel]? {
        
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    private lazy var layout : UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = kWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZJRecreationListItem.self, forCellWithReuseIdentifier:ZJRecreationListItem.identifier())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
        
    }()
    
    override func zj_setUpAllView() {
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension ZJFaceScoreCell : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.faceScoreDataList != nil){
            return (self.faceScoreDataList?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJRecreationListItem.identifier(), for: indexPath) as! ZJRecreationListItem
        item.faceHotModel = self.faceScoreDataList?[indexPath.item]
        return item
        
    }
    
}
