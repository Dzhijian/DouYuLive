//
//  ZJCateCollectionHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCateCollectionHeadView: UICollectionReusableView {
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = kWhite
        collectionView.register(ZJSelectCateItem.self, forCellWithReuseIdentifier: ZJSelectCateItem.identifier())
        return collectionView
    }()
    
    lazy var dataList : [ZJChildCateList] = [ZJChildCateList]()
    
    var cateList : [ZJChildCateList]? {
        didSet{
            self.dataList.removeAll()
            var cateItem = ZJChildCateList()
            cateItem.id = "1"
            cateItem.name = "全部"
            self.dataList.append(cateItem)
            for (_,item) in (cateList?.enumerated())! {
                self.dataList.append(item)
            }
            self.collectionView.reloadData()
        }
    }
    
    
    private var showNum : Int = 5
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ZJCateCollectionHeadView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJSelectCateItem.identifier(), for: indexPath) as! ZJSelectCateItem
        let model = self.dataList[indexPath.item]
        item.titleLab.text = model.name
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW / CGFloat(showNum) , height: Adapt(40))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

// MARK: - 配置 UI
extension ZJCateCollectionHeadView {
    
    private func setUpAllView() {
        backgroundColor = kWhite
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(Adapt(80))
        }
    }
    
    
}
