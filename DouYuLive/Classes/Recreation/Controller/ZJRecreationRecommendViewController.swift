//
//  ZJRecreationRecommendViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/15.
//  Copyright © 2018年 邓志坚. All rights reserved.
//  娱乐推荐

import UIKit

private let kItemW = (kScreenW - 10) / 2
private let kItemH = kItemW * 5 / 4
private let kHeaderViewId = "kHeaderViewId"

// MARK: 推荐
class ZJRecreationRecommendViewController: ZJBaseViewController {

    private lazy var layout : UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: kScreenW, height: Adapt(45))
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = kWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZJRecreationListItem.self, forCellWithReuseIdentifier:ZJRecreationListItem.identifier())
        collectionView.register(ZJRecreationHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - CollectionViewDelegate
extension ZJRecreationRecommendViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJRecreationListItem.identifier(), for: indexPath) as! ZJRecreationListItem
        //        item.allModel = self.allLiveData.list[indexPath.item]
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId, for: indexPath) as! ZJRecreationHeaderView
        header.configWithTitle(title: "sectionTitle")
        
        return header;
    }
    
    
}

// 配置 UI 视图
extension ZJRecreationRecommendViewController {
    
    private func setUpAllView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
