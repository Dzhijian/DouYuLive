//
//  ZJRecommendViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - kItemMargin * 3) / 2
private let kItemH = kItemW * 6 / 7
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kRecommendHeaderViewID = "kRecommendHeaderViewID"

class ZJRecommendViewController: ZJBaseViewController ,UIScrollViewDelegate{
    
    private lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = kItemMargin
//        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = kWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ZJLiveListItem.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(ZJCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(ZJRecommendHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommendHeaderViewID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        // 获取热门推荐列表数据
        loadHotRecommendListData()
        
        getActivityList()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 列表滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY > 120 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarHidden)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarNotHidden)
        }
    }

    
}

// MARK: - 网络请求
extension ZJRecommendViewController {
    
    // 获取热门推荐数据
    
    private func loadHotRecommendListData() {
        let dict : [String : String] = ["limit":"10","client_sys":"ios","offset":"0"]
        ZJNetWorking.requestData(type: .POST, URlString:ZJRecommendHotURL , parameters: dict) { (response) in
            print(response)
        }
    }
    
    private func getActivityList() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJActivityListURL, parameters: nil) { (response) in
            print(response)
        }
    }
}

// MARK: - 遵守UICollectionView的协议
extension ZJRecommendViewController : UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommendHeaderViewID, for: indexPath)
            
            return headerView
            
        }else{
            
            // 取出 section 的 headerView
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
            headerView.backgroundColor = kWhite
            return headerView
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: kScreenW, height: Adapt(330))
        }else{
            return CGSize(width: kScreenW, height: 50)
        }
    }
    
}


// MARK: - 设置 UI
extension ZJRecommendViewController {
    private func setUpUI(){
        // 添加 collectionView
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
