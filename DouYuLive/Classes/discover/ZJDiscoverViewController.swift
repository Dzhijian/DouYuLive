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
    private lazy var anchorRankList : [ZJAnchorRankList] = [ZJAnchorRankList]()
    private lazy var gameList : [ZJDiscoverGameList] = [ZJDiscoverGameList]()
    private lazy var activityList : [ZJDiscoverActivityList] = [ZJDiscoverActivityList]()
    
    private lazy var sectionTitles : [String] = {
        let titles : [String] = ["语音直播","附近的颜值","热门视频","主播榜","","活动"]
        return titles
    }()
    
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
        collectionView.register(ZJDiscoverRankItem.self, forCellWithReuseIdentifier: ZJDiscoverRankItem.identifier())
        collectionView.register(ZJDiscoverGameItem.self, forCellWithReuseIdentifier: ZJDiscoverGameItem.identifier())
        collectionView.register(ZJDiscoverActivityItem.self, forCellWithReuseIdentifier: ZJDiscoverActivityItem.identifier())
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
        getAnchorListData()
        getGameListData()
        getActivityData()
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
            }
        }
    }
    
    // 获取主播排行列表
    private func getAnchorListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJAnchorRankListURL) { (response) in
            let data = try? ZJDecoder.decode(ZJAnchorRankData.self, data: response)
            if data != nil {
                self.anchorRankList = (data?.data)!
                self.collectionView.reloadData()
//                print(data!)
            }
        }
    }
    
    // 获取赛事直播列表
    private func getGameListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJDiscoverCompetitionURL) { (response) in
            let data = try? ZJDecoder.decode(ZJDiscoverGameData.self, data: response)
            if data != nil {
                self.gameList = (data?.list)!
                self.collectionView.reloadData()
//                print(data!)
            }
        }
    }
    
    private func getActivityData(){
        ZJNetWorking.requestData(type: .GET, URlString: ZJDiscoverActivityURL) { (response) in
            let data = try? ZJDecoder.decode(ZJDiscoverActivityData.self, data: response)
            if data != nil {
//                print(data!)
                self.activityList = (data?.list)!
                self.collectionView.reloadData()
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.voiceList.count
        case 1:
            return 4
        case 2:
            return self.hotVideoList.count
        case 3,4,5:
            return 1
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
        case 3:
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJDiscoverRankItem.identifier(), for: indexPath) as! ZJDiscoverRankItem
            cell.rankData = self.anchorRankList
            return cell
        case 4:
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJDiscoverGameItem.identifier(), for: indexPath) as! ZJDiscoverGameItem
            cell.contentView.backgroundColor = kPurple
            cell.gameList = self.gameList
            return cell
        case 5:
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ZJDiscoverActivityItem.identifier(), for: indexPath) as! ZJDiscoverActivityItem
            let imgUrlStr = self.activityList[indexPath.item].act_pic
            cell.configImgUrlStr(imgUrlStr: imgUrlStr ?? "")
            return cell
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
        case 3:
            return CGSize(width: kScreenW, height: Adapt(150))
        case 4:
            return ZJDiscoverGameItem.itemHeightWithModel(model: "")
        case 5:
            return CGSize(width: kScreenW, height:Adapt(250*9/16)+Adapt(20))
        default:
            return CGSize(width: kItemW, height: 0)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionHeadView, for: indexPath)
            return headView
        }
        
        let sectionHeadView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectionSectionHeadView, for: indexPath) as! ZJDiscoverSectionHeadView

            sectionHeadView.configTitle(title:self.sectionTitles[indexPath.section])
        
        return sectionHeadView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return section == 0 ? CGSize(width: kScreenW, height: Adapt(130)+kCateItemWH*2) : CGSize(width: kScreenW, height: Adapt(50))
    }
    
}
