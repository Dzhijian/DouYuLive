
//  ZJAllViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemW = (kScreenW - 10) / 2
private let kItemH = kItemW * 4 / 5

class ZJAllViewController: ZJBaseViewController {
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = kWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZJLiveListItem.self, forCellWithReuseIdentifier:ZJLiveListItem.identifier())
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var allLiveData : ZJLiveListData = ZJLiveListData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
        getAllLiveData()
    }

    // 列表滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY > 120 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarHidden)
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarNotHidden)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - 网络请求
extension  ZJAllViewController {
    
    private func getAllLiveData() {
        
        ZJNetWorking.requestData(type: .GET, URlString: ZJAllLiveListURL) { (response) in
            do {
                let data = try JSONDecoder().decode(ZJLiveListData.self, from: response)
                self.allLiveData = data
                self.collectionView.reloadData()
            }catch{}
            
        }
    }
}


// 配置 UI 视图
extension ZJAllViewController  {
    
    private func setUpAllView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}


extension ZJAllViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLiveData.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath) as! ZJLiveListItem
        item.allModel = self.allLiveData.list[indexPath.item]
        return item
    }
}



