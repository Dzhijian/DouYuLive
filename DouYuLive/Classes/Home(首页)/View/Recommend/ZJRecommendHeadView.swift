//
//  ZJRecommendHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
private let ItemMargin : CGFloat = Adapt(10)
private let ItemWidth : CGFloat = (kScreenW - ItemMargin * 2) / 4
private let ItemHeight :CGFloat = ItemWidth
class ZJRecommendHeadView: UICollectionReusableView {
    
    var activityList : [ZJRecommendActivityList]?{
        didSet{
            // 刷新
            guard activityList?.count ?? 0 > 0 else {return }
            self.activityView.dataArray = activityList! as [AnyObject]
        }
    }
    
    var recomCateList : [ZJRecomCateList]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: ItemWidth, height: ItemHeight)
        return layout
    }()
    

    // 活动滚动视图
    private lazy var activityView : ZJCarouselView = {
        let activityView = ZJCarouselView(frame: CGRect(x: 0, y: 0, width: kScreenW-2*ItemMargin, height: Adapt(65)))
        activityView.position = .centeredVertically
        activityView.scrollDirection = .vertical
        activityView.delegate = self
        activityView.dataScoure = self
        activityView.pageStyle = .none
        activityView.autoScrollTimeInterval = 3.0
        
        activityView.customCellClass = ZJActivityItem.self
        return activityView
    }()
    
    private lazy var titleLab : UILabel = {
        let titleLab = UILabel()
        titleLab.text = "热门推荐"
        titleLab.textColor = kMainTextColor
        titleLab.font = BoldFontSize(18)
        return titleLab
    }()
    
    /// 推荐分类视图
    private lazy var collectionView : UICollectionView = {
        let colletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.backgroundColor = kWhite
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.showsVerticalScrollIndicator = false
        colletionView.bounces = false
        colletionView.register(ZJCategoryItem.self, forCellWithReuseIdentifier: ZJCategoryItem.identifier())
        return colletionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - 遵守协议
extension ZJRecommendHeadView : ZJCarouselViewDelegate, ZJCarouselViewDataScoure {
    
    func zj_carouseViewDataScoure(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ZJBaseCarouselCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJActivityItem.identifier(), for: indexPath) as! ZJActivityItem
        item.contentView.backgroundColor = kBGGrayColor
        if self.activityList?.count ?? 0 > 0 {
            item.model = self.activityList?[indexPath.item]
        }
        return item
    }
    
    func zj_carouseView(_ carouseView: ZJCarouselView, scrollTo scrollIndex: NSInteger) {
            print("滚动到第\(scrollIndex)个")
    }
    func zj_carouseView(_ carouseView: ZJCarouselView, didSelectedItemIndex didSectedIndex: NSInteger) {
        print("选中\(didSectedIndex)")
    }
    
    
}


extension ZJRecommendHeadView : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.recomCateList?.count ?? 0) > 8 ? 8 : (self.recomCateList?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZJCategoryItem.identifier(), for: indexPath) as! ZJCategoryItem
        cell.model = self.recomCateList?[indexPath.item]
        return cell
    }
}

extension ZJRecommendHeadView {
    func setUpAllView() {
        addSubview(collectionView)
        addSubview(activityView)
        addSubview(titleLab)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(ItemMargin)
            make.right.equalTo(-ItemMargin)
            make.height.equalTo(ItemHeight*2)
        }
        
        collectionView.layer.masksToBounds = false
        collectionView.layer.cornerRadius = 3
        collectionView.layer.shadowColor = colorWithRGBA(44, 44, 44, 1).cgColor
        collectionView.layer.shadowOpacity = 0.3
        collectionView.layer.shadowRadius = 4
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        activityView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(Adapt(20))
            make.left.equalTo(ItemMargin)
            make.right.equalTo(-ItemMargin)
            make.height.equalTo(Adapt(65))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(ItemMargin)
            make.bottom.equalTo(Adapt(-15))
            
        }
    }
}
