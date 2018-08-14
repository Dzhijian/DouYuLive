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

    // 分类数据
    private lazy var cateListData : ZJRecreationCateData = ZJRecreationCateData()
    
    private lazy var pageView : DNSPageView = {
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleScrollEnable = true
        style.isScaleEnable = true
        style.titleColor = colorWithRGBA(220, 220, 220, 1.0)
        style.titleSelectedColor = kWhite //colorWithRGBA(255, 255, 255, 1.0)
        style.titleFontSize = 14
        style.isBoldFont = true
        // 创建对应的DNSPageView，并设置它的frame
        let pageView = DNSPageView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: style, titles: titles, childViewControllers: controllers)
        return pageView
    }()
    
    // 标题数组
    private lazy var titles : [String] = {
        var titles : [String] = ["推荐"]
        for (index,item) in cateListData.data.enumerated() {
            titles.append(item.cate_name!)
        }
        return titles
    }()
    
    private lazy var controllers : [UIViewController] = {
        // 创建每一页对应的controller
        let childViewControllers: [UIViewController] = titles.map { _ -> UIViewController in
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.orange
            return controller
        }
        return childViewControllers
    }()
    
    
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
//        setUpAllView()
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
                self.setUpAllView()
            }
        }
    }
}

// MARK: - 配置 UI
extension ZJRecreationViewController {
    
    private func setUpAllView() {
        
        
        view.addSubview(pageView)
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
