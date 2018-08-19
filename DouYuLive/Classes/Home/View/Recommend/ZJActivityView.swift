//
//  ZJActivityView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJActivityView: ZJBaseView {
    
    var activityList : [ZJRecommendActivityList]? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    private var autoTimer : Timer?
    private var index : Int = 0
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kScreenW - Adapt(20), height: Adapt(65))
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = kBGGrayColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZJActivityItem.self, forCellWithReuseIdentifier: ZJActivityItem.identifier())
        return collectionView
    }()
    override func zj_initWithAllView() {
        
        self.backgroundColor = kBGGrayColor
        setUpAllView()
        startTimer()
    }
    
    func startTimer() {
        //设置一个定时器，每三秒钟滚动一次
        autoTimer = Timer.scheduledTimer(timeInterval: 3, target: self,
                                               selector: #selector(self.scrollAction),
                                               userInfo: nil, repeats: true)
    }
    
    @objc private func scrollAction() {
        // 如果到达最后一个,则变成第四个
        if collectionView.contentOffset.y == CGFloat(CGFloat((self.activityList?.count)! - 1) * self.collectionView.bounds.height) {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.contentOffset.y = 0
            }
        }else {
            // 每过一秒,contentOffset.x增加一个cell的宽度
            UIView.animate(withDuration: 0.3) {
                self.collectionView.contentOffset.y += self.collectionView.bounds.size.height
            }
        }
    }
    
    
    
}


// MARK: - 遵守协议
extension ZJActivityView : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activityList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJActivityItem.identifier(), for: indexPath) as! ZJActivityItem
        item.contentView.backgroundColor = kBGGrayColor
        item.model = self.activityList?[indexPath.item]
        return item
    }
    
    
}

// 配置 UI 视图
extension ZJActivityView {
    
    private func setUpAllView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
