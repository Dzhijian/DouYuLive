//
//  ZJLOLViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
let kContentHeight = kScreenH - kStatuHeight - kCateTitleH - kTabBarHeight - Adapt(50)

private let kScrollViewHeight : CGFloat = kScreenW * 9 / 18
class ZJLOLViewController: ZJBaseViewController {
    private let childAllId : Int = 1
    private var cateBanner : ZJCateBanner = ZJCateBanner()
    private var childCateData : ZJChildCateData = ZJChildCateData()
    private var lolLiveData : ZJLiveListData = ZJLiveListData()
    private var childCateId : String = "2_1"
    // 显示视图索引
    private var showIndex : Int = 0
    //初始化信号量为1
    let semaphoreA = DispatchSemaphore(value: 1)
    //第二个信号量为0
    let semaphoreB = DispatchSemaphore(value: 0)
    let semaphoreC = DispatchSemaphore(value: 0)
    let semaphoreLast = DispatchSemaphore(value: 0)
    private lazy var headView : ZJHomeCateHeaderView = {
        let scrollView = ZJHomeCateHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(120)))
        return scrollView
    }()
    private lazy var mainTable : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = kWhite
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ZJLiveListCell.self, forCellReuseIdentifier: ZJLiveListCell.identifier())
        tableView.register(ZJLiveContentCell.self, forCellReuseIdentifier: ZJLiveContentCell.identifier())
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
        
        loadData()
        
        // 显示加载动画
        ZJProgressHUD.showProgress(supView: self.view, bgFrame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatuHeight-kTabBarHeight-kNavigationBarHeight),imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
}


// MARK: - 网络请求
extension ZJLOLViewController {
    
    // 按顺序加载数据
    func loadData() {
        let queue = DispatchQueue(label: "com.douyuLive.discover.queue", qos: .utility, attributes: .concurrent)
        let mainQueue = DispatchQueue.main
        
        queue.async {
            self.semaphoreA.signal()
            self.getBannerListData()
        }
        queue.async {
            self.semaphoreB.wait()
            self.getChildCateListData()
        }
        queue.async {
            self.semaphoreC.wait()
            self.getLOLLiveData()
        }
        queue.async{
            if self.semaphoreLast.wait(wallTimeout: .distantFuture) == .success{
                mainQueue.async {
                    self.mainTable.reloadData()
                    ZJProgressHUD.hideAllHUD()
                    
                }
            }
        }
    }
    
    // 获取 banner 轮播图数据
    private func getBannerListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJCateBannerURL) { (response) in
            self.semaphoreB.signal()
            let data = try? ZJDecoder.decode(ZJCateBanner.self, data : response)
            if data != nil {
                self.cateBanner = data!
                self.headView.configBnanerList(bannerList: self.cateBanner.slide_list)
            }
        }
    }
    
    private func getChildCateListData(){
        
        // 获取子类分类列表
        ZJNetWorking.requestData(type: .GET, URlString: ZJChildCateListURL) { (response) in
            self.semaphoreC.signal()
            let data = try? ZJDecoder.decode(ZJChildCateData.self, data : response)
            guard (data != nil) else { return }
            self.childCateData = data!
            
        }
    }
    
    private func getLOLLiveData() {
        // 获取全部数据
        let urlStr = "\(ZJLOLLiveListURL)/\(self.childCateId)/0/20/ios?client_sys=ios"
        ZJNetWorking.requestData(type: .GET, URlString: urlStr) { (response) in
            self.semaphoreLast.signal()
            let data = try? ZJDecoder.decode(ZJLiveListData.self, data : response)
            guard (data != nil) else { return }
            self.lolLiveData = data!
            
        }
    }
    
    func getVideoListData() {
        //当前时间的时间戳
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let urlStr = "\(ZJVideoListURL)&time=\(timeStamp)"
        ZJNetWorking.requestData(type: .GET, URlString: urlStr) { (response) in
            print("斗鱼直播视频")
        }
    }
    
    
    // 查看其它分类的数据
    private func  getOtherLOLLiveData() {
        // 获取全部数据
        let urlStr = "\(ZJLOLLiveListURL)/\(self.childCateId)/0/20/ios?client_sys=ios"
        ZJNetWorking.requestData(type: .GET, URlString: urlStr) { (response) in
            
            let data = try? ZJDecoder.decode(ZJLiveListData.self, data : response)
            guard (data != nil) else { return }
            self.lolLiveData = data!
            self.mainTable.reloadData()
            
        }
    }
}


// MARK: 配置 UI 视图
extension ZJLOLViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headView
    }
}


// MARK: 遵守协议
extension ZJLOLViewController :  UITableViewDataSource,UITableViewDelegate  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: ZJLiveListCell.identifier(), for: indexPath) as! ZJLiveListCell
        cell.cellType = .ZJCellHomeLOL
        cell.allId = self.childAllId
        cell.delegate = self
        // 显示视图
        cell.configShowView(index: showIndex)
        
        if self.lolLiveData.list.count > 0 {
            cell.liveRoomList = self.lolLiveData.list
        }
        if self.childCateData.data.count > 0 {
            cell.cateListData = self.childCateData.data
        }
        
        //  MARK: 控制导航栏
        cell.scrollBlock = { ishidden in
            if ishidden {
                NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarHidden)
            }else{
                NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarNotHidden)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kContentHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = ZJCateSectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        headerView.setUpTitles(titles: ["直播","视频"],margin: Adapt(40),selectIndex: self.showIndex)
        
        headerView.btnClickBlock = {[weak self] index in
            self?.showIndex = index
            self?.mainTable.reloadData()
        }
        
        return headerView
    
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
}

// MARK: - ZJChildCateSelectDelegate
extension ZJLOLViewController : ZJChildCateSelectDelegate {
    
    func childCateSelectAction(cateId: String,index : Int) {
        
        if index == 0 {
            self.childCateId = "2_\(cateId)"
        }else{
            self.childCateId = "3_\(cateId)"
        }
        print(self.childCateId)
        // 加载数据
        getOtherLOLLiveData()
    }
    
}

