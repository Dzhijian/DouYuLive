
//  ZJAllViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import ESPullToRefresh

private let kItemW = (kScreenW - 10) / 2
private let kItemH = kItemW * 4 / 5

class ZJAllViewController: ZJBaseViewController {
    private var formValue : Int = 0
    private var toValue : Int = 20
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
    
    private var allLiveList : [ZJLiveItemModel] = [ZJLiveItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
        
        ZJProgressHUD.showProgress(supView: self.view, bgFrame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatuHeight-kTabBarHeight-kNavigationBarHeight),imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
        
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
        
        let urlStr : String = ZJLiveItemModelURL + "roomlist/0_0/\(formValue)/\(toValue)/ios?client_sys=ios"
        
        ZJNetWorking.requestData(type: .GET, URlString: urlStr) { (response) in
                let data = try? ZJDecoder.decode(ZJLiveListData.self, data: response)
                if data != nil {
                    if self.formValue == 0 {
                        self.allLiveList = data!.list
                    }else{
                        for (_,item) in (data?.list.enumerated())!{
                            self.allLiveList.append(item)
                        }
                    }
                    ZJProgressHUD.hideAllHUD()
                    self.collectionView.reloadData()
                }
                self.collectionView.es.stopPullToRefresh()
                /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                self.collectionView.es.stopLoadingMore()
                /// 通过es_noticeNoMoreData()设置footer暂无数据状态
//                self.collectionView.es.noticeNoMoreData()
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
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = ZJRefreshView(frame: CGRect.zero)
        
        self.collectionView.es.addPullToRefresh(animator: header) { [weak self] in
            self?.getAllLiveData()
        }
        
//        self.collectionView.es.addInfiniteScrolling {
//            [unowned self] in
//
//            self.getAllLiveData()
//        }
    }
}


extension ZJAllViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLiveList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath) as! ZJLiveListItem
        item.liveModel = self.allLiveList[indexPath.item]
        return item
    }
}



