//
//  ZJLOLViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kScrollViewHeight : CGFloat = kScreenW * 9 / 18
class ZJLOLViewController: ZJBaseViewController {
    
    private var cateBanner : ZJCateBanner = ZJCateBanner()
    
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
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
        getBannerListData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - 网络请求
extension ZJLOLViewController {
    
    private func getBannerListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJCateBannerURL) { (response) in
            
            let data = try? ZJDecoder.decode(ZJCateBanner.self, data : response)
            if data != nil {
                self.cateBanner = data!
                self.headView.configBnanerList(bannerList: self.cateBanner.slide_list)
                print(self.cateBanner)
            }
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
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: ZJLiveListCell.identifier(), for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenH - kStatuHeight - kCateTitleH - kTabBarHeight - Adapt(50)
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
