//
//  ZJFollowLiveViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFollowLiveViewController: ZJBaseViewController {
    
    private lazy var interesList : [ZJFollowInterseList] = [ZJFollowInterseList]()
    
    private lazy var rankList : [ZJFollowRankList] = [ZJFollowRankList]()
    //初始化信号量为1
    let semaphoreA = DispatchSemaphore(value: 1)
    let semaphoreB = DispatchSemaphore(value: 0)
    let semaphoreC = DispatchSemaphore(value: 0)
    private lazy var headView : ZJFollowLiveHeadView = {
        let headView = ZJFollowLiveHeadView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(200)))
        headView.backgroundColor = kWhite
        return headView
    }()
    private var CellHeight : CGFloat = Adapt(0)
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = kWhite
        mainTable.separatorStyle = .none
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(ZJFollowLiveCell.self, forCellReuseIdentifier: ZJFollowLiveCell.identifier())
        return mainTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kWhite
        setUpAllview()
        asyncLoadData()
        
        headView.loginBtnCallBack = {[weak self] in
            
            self?.navigationController?.pushViewController(ZJProfileViewController(), animated: true)
        }
        
        ZJProgressHUD.showProgress(supView: self.view, bgFrame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatuHeight-kTabBarHeight-kNavigationBarHeight),imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
        
        
    }
    
}

// MARK: - 网络请求
extension ZJFollowLiveViewController {
    
    func asyncLoadData() {
        
        let queue = DispatchQueue(label: "com.douyuLive.cate1.queue", qos: .utility, attributes: .concurrent)
        
        queue.async {
            self.semaphoreA.signal()
            self.getInterestListData()
        }
        queue.async {
            self.semaphoreB.wait()
            self.getRankListData()
        }
        queue.async{
            if self.semaphoreC.wait(wallTimeout: .distantFuture) == .success{
                DispatchQueue.main.async {
                    ZJProgressHUD.hideAllHUD()
                    self.mainTable.reloadData()
                }
            }
        }
    }
    
    private func getInterestListData() {
        
        // 获取可能感兴趣列表
        ZJNetWorking.requestData(type: .GET, URlString: ZJFollowInterestURL) { (response) in
            self.semaphoreB.signal()
            let data = try? ZJDecoder.decode(ZJFollowInterseData.self, data: response)
            if data != nil{
                self.interesList = (data?.data)!
            }
        }
    }
    
    private func getRankListData() {
        
        // 获取排行榜列表
        ZJNetWorking.requestData(type: .GET, URlString: ZJFollowRankURL) { (response) in
            self.semaphoreC.signal()
            let data = try? ZJDecoder.decode(ZJFollowRankData.self, data: response)
            if data != nil {
                self.rankList = (data?.data)!
                self.headView.rankList = self.rankList
            }
            
        }
    }
}

// MARK: - 遵守UITableViewDelegate,UITableViewDataSource协议
extension ZJFollowLiveViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: ZJFollowLiveCell.identifier(), for: indexPath) as! ZJFollowLiveCell
        cell.dataSource = self.interesList
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZJFollowLiveCell.cellHeightWithModel(model: self.interesList)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ZJCollectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        header.configTitle(title: "可能感兴趣的")
        header.botLine.isHidden = true
        header.topLine.isHidden = true
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
}

// MARK: - 配置 UI
extension ZJFollowLiveViewController {
    
    private func setUpAllview() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headView
    }
}
