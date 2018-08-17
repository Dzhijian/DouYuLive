//
//  ZJDiscoverViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
// headView size
private let kCateItemWH = (kScreenW - Adapt(20)) / 4
private let kItemW = (kScreenW - 10) / 2

// 直播列表 Size
private let kLiveItemW = (kScreenW - 10) / 2
private let kLiveItemH = kLiveItemW * 9 / 16 + Adapt(30)

// 颜值 size
private let kFaceItemW = (kScreenW - 10) / 2
private let kFaceItemH = kFaceItemW * 5 / 4 - Adapt(10)

private let kCollectionHeadView = "kCollectionHeadView"
private let kCollectionSectionHeadView = "kCollectionSectionHeadView"

class ZJDiscoverViewController: ZJBaseViewController {

    private lazy var voiceList : [ZJLiveItemModel] = [ZJLiveItemModel]()
    private lazy var hotVideoList : [ZJFollowVideoList] = [ZJFollowVideoList]()
    
    private lazy var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = kWhite
        collectionView.register(ZJBaseCollectionCell.self, forCellWithReuseIdentifier: ZJBaseCollectionCell.identifier())
        collectionView.register(ZJLiveListItem.self, forCellWithReuseIdentifier: ZJLiveListItem.identifier())
        collectionView.register(ZJRecreationListItem.self, forCellWithReuseIdentifier: ZJRecreationListItem.identifier())
        collectionView.register(ZJDiscoverHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionHeadView)
        collectionView.register(ZJDiscoverSectionHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionSectionHeadView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUpAllView()
        
        getVoiceListData()
        getHotLiveListData()
        getFaceScoreListData()
    }
    
}

// MARK: - 网络请求
extension ZJDiscoverViewController {
    
    // 获取语音直播列表
    private func getVoiceListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJVoiceListURL) { (response) in
            let data = try? ZJDecoder.decode(ZJLiveListData.self, data: response)
            if data != nil {
                self.voiceList = (data?.list)!
                self.collectionView.reloadData()
            }
        }
    }
    
    // 获取颜值列表
    private func getFaceScoreListData() {
        let time : Int = Int(NSDate().timeIntervalSince1970)
        
        let urlStr : String = "\(ZJDiscoverFaceListURL)&time=\(time)&auth=78b5edde09476a10f789ff8d56564d7a"
        ZJNetWorking.requestData(type: .GET, URlString: urlStr) { (response) in
            let data = try? ZJDecoder.decode(ZJNearFaceScoreData.self, data: response)
            if data != nil {
                print(data!)
            }
            
        }
    }
    
    // 获取热门视频列表
    private func getHotLiveListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJDiscoverVideoListURL) { (response) in
            let data = try? ZJDecoder.decode(ZJFollowVideoData.self, data: response)
            if data != nil {
                self.hotVideoList = (data?.data)!
                self.collectionView.reloadData()
                print(data!)
            }
        }
    }
}

// 配置 UI 视图
extension ZJDiscoverViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private func setUpAllView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.voiceList.count
        case 1:
            return 4
        case 2:
            return self.hotVideoList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath) as! ZJLiveListItem
            item.descLab.isHidden = true
            item.liveModel = self.voiceList[indexPath.item]
            return item
        
        case 1:
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJRecreationListItem.identifier(), for: indexPath) as! ZJRecreationListItem
            //        item.allModel = self.allLiveData.list[indexPath.item]
            return item
        case 2:
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: ZJLiveListItem.identifier(), for: indexPath) as! ZJLiveListItem
            item.descLab.isHidden = true
            item.hotVideoModel = self.hotVideoList[indexPath.item]
            return item
            
        default:
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJBaseCollectionCell.identifier(), for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: kLiveItemW, height: kLiveItemH)
        case 1:
            return CGSize(width: kFaceItemW, height: kFaceItemH)
        case 2:
            return CGSize(width: kLiveItemW, height: kLiveItemH)
        default:
            return CGSize(width: kItemW, height: kLiveItemH)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionHeadView, for: indexPath)
            return headView
        }
        
        let sectionHeadView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionSectionHeadView, for: indexPath) as! ZJDiscoverSectionHeadView
        if indexPath.section == 1 {
            sectionHeadView.configTitle(title: "附近的颜值")
        }else if indexPath.section == 2{
            sectionHeadView.configTitle(title: "热门视频")
        }
        
        return sectionHeadView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return section == 0 ? CGSize(width: kScreenW, height: Adapt(130)+kCateItemWH*2) : CGSize(width: kScreenW, height: Adapt(60))
    }
    
}
