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
    
    private var cateBanner : ZJCateBanner = ZJCateBanner()
    private var childCateData : ZJChildCateData = ZJChildCateData()
    private var lolLiveData : ZJLiveListData = ZJLiveListData()
    
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
        getBannerListData()
        getChildCateListData()
        getLOLLiveData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - 网络请求
extension ZJLOLViewController {
    // 获取 banner 轮播图数据
    private func getBannerListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJCateBannerURL) { (response) in
            
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
            
            let data = try? ZJDecoder.decode(ZJChildCateData.self, data : response)
            guard (data != nil) else { return }
            self.childCateData = data!
            self.mainTable.reloadData()
            
        }
    }
    
    private func getLOLLiveData() {
        // 获取全部数据
        ZJNetWorking.requestData(type: .GET, URlString: ZJLOLLiveListURL) { (response) in
            do {
                let data = try JSONDecoder().decode(ZJLiveListData.self, from: response)
                self.lolLiveData = data
                self.mainTable.reloadData()
            }catch{}
            
        }
    }
}


// 配置 UI 视图
extension ZJLOLViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headView
    
        
    }
    
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


// 遵守协议
extension ZJLOLViewController :  UITableViewDataSource,UITableViewDelegate  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: ZJLiveListCell.identifier(), for: indexPath) as! ZJLiveListCell
        if self.lolLiveData.list.count > 0 {
            cell.liveRoomList = self.lolLiveData.list
        }
        if self.childCateData.data.count > 0 {
            cell.cateListData = self.childCateData.data
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kContentHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = ZJCateSectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        headerView.setUpTitles(titles: ["直播","视频"])
        return headerView
    
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
}
