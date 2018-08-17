//
//  ZJDiscoverHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/17.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemWH = (kScreenW - Adapt(20)) / 4

class ZJDiscoverHeadView: UICollectionReusableView {
    
    private lazy var titleArr : [String] = {
        let titleArr : [String] = ["视频","音频","商城","小游戏","车队","签到","星球","敬请期待"]
        return titleArr
    }()
    private lazy var imageNameArr : [String] = {
        let imageNameArr : [String] = ["video_entrance_icon","radio_entrance_icon","mall_entrance_icon","game_entrance_icon","motorcade_entrance_icon","sign_entrance_icon","star_entrance_icon","unknown_entrance_icon"]
        return imageNameArr
    }()
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: kItemWH, height: kItemWH)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = kWhite
        collectionView.register(ZJDiscoverCateItem.self, forCellWithReuseIdentifier: ZJDiscoverCateItem.identifier())
        return collectionView
    }()
    
    
    private lazy var activityImgV : UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = kOrange
        imgV.layer.cornerRadius = 4
        imgV.layer.masksToBounds = true
        return imgV
    }()
    
    
    private lazy var sectionTitleLab : UILabel = {
      let lab = UILabel()
        lab.textColor = kMainTextColor
        lab.font = BoldFontSize(15)
        lab.text = "语音直播"
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: -
extension ZJDiscoverHeadView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArr.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJDiscoverCateItem.identifier(), for: indexPath) as! ZJDiscoverCateItem
        
        item.configItem(title: self.titleArr[indexPath.item],imageName: self.imageNameArr[indexPath.item])
        return item
    }
    
    
 
}

// 配置 UI 视图
extension ZJDiscoverHeadView {
    
    private func setUpAllView() {
        backgroundColor = kWhite
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(Adapt(10))
            make.right.equalTo(Adapt(-10))
            make.height.equalTo(kItemWH*2)
        }
        
        addSubview(activityImgV)
        activityImgV.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(Adapt(15))
            make.left.equalTo(Adapt(10))
            make.right.equalTo(Adapt(-10))
            make.height.equalTo(Adapt(45))
        }
        
        addSubview(sectionTitleLab)
        sectionTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(activityImgV.snp.bottom).offset(Adapt(20))
            make.left.equalTo(Adapt(15))
            make.height.equalTo(Adapt(20))
        }
    }
    
    
}
