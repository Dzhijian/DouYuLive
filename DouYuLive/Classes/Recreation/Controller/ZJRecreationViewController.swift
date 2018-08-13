//
//  ZJRecreationViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemW = (kScreenW - 10) / 2
private let kItemH = kItemW * 5 / 4
private let kHeaderViewId = "kHeaderViewId"
class ZJRecreationViewController: ZJBaseViewController {

    private lazy var cateListData : ZJRecreationCateData = ZJRecreationCateData()
    
    private lazy var layout : UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: kScreenW, height: Adapt(50))
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
        self.view.backgroundColor = kWhite
        setUpAllView()
        loadChildCateListData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - 网络请求
extension ZJRecreationViewController {
    
    // 获取子类分类数据
    private func loadChildCateListData() {
        
        ZJNetWorking.requestData(type: .GET, URlString: RecreationChildCateURL) { (response) in
            let data = try? ZJDecoder.decode(ZJRecreationCateData.self, data : response)
            if data != nil {
               self.cateListData = data!
                print(self.cateListData)
            }
        }
    }
}

// MARK: - CollectionViewDelegate
extension ZJRecreationViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJRecreationListItem.identifier(), for: indexPath) as! ZJRecreationListItem
//        item.allModel = self.allLiveData.list[indexPath.item]
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId, for: indexPath)
        
        return header;
    }
    
    
}

// MARK: - 配置 UI
extension ZJRecreationViewController {
    
    private func setUpAllView() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
