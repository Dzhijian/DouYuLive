//
//  ZJOutdoorsViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/15.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


/// 户外
class ZJOutdoorsViewController: ZJBaseViewController {
    
    var faceScoreHotData : ZJLiveListData = ZJLiveListData()
    private let childAllId : Int = 124
    private var childCateId : String = "2_124"
    private var childCateData : ZJChildCateData = ZJChildCateData()
    private lazy var showIndex : Int = 0
    private lazy var headView : ZJHomeCateHeaderView = {
        let scrollView = ZJHomeCateHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(120)))
        return scrollView
    }()
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .plain)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = kWhite
        mainTable.separatorStyle = .none
        mainTable.bounces = false
        mainTable.showsHorizontalScrollIndicator = false
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(ZJLiveListCell.self, forCellReuseIdentifier: ZJLiveListCell.identifier())
        return mainTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
        
        getChildCateListData()
        getOutDoorsLiveListData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - 网络请求
extension ZJOutdoorsViewController {
    
    private func getChildCateListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJOutDoorsChildCateURL) { (response) in
            let data = try? ZJDecoder.decode(ZJChildCateData.self, data: response)
            
            if data != nil {
                self.childCateData = data!
                self.mainTable.reloadData()
                print(data!)
            }
        }
    }
    
    private func getOutDoorsLiveListData() {
        let URLStr : String = "\(ZJOutDoorsListURL)\(self.childCateId)/0/20/ios?client_sys=ios"
        ZJNetWorking.requestData(type: .GET, URlString: URLStr) { (response) in
            let data = try? ZJDecoder.decode(ZJLiveListData.self, data : response)
            if data != nil {
                self.faceScoreHotData = data!
                self.mainTable.reloadData()
            }
        }
    }
}


// MARK: - 配置 UI
extension ZJOutdoorsViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headView
    }
}

// MARK: - 遵守ZJChildCateSelectDelegate协议
extension ZJOutdoorsViewController : ZJChildCateSelectDelegate {
    
    func childCateSelectAction(cateId: String,index : Int) {
        
        if index == 0 {
            self.childCateId = "2_\(cateId)"
        }else{
            self.childCateId = "3_\(cateId)"
        }
        
        getOutDoorsLiveListData()
    }
  
}


// MARK: - 遵守UITableViewDelegate,UITableViewDataSource协议
extension  ZJOutdoorsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: ZJLiveListCell.identifier(), for: indexPath) as! ZJLiveListCell
        cell.cellType = .ZJCellRecreationOutDoor
        cell.allId = self.childAllId
        cell.delegate = self
        // 显示视图
        cell.configShowView(index: showIndex)
        
        if self.faceScoreHotData.list.count > 0 {
            cell.outDoorsList = self.faceScoreHotData.list
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ZJCateSectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        headerView.setUpTitles(titles: ["直播","视频","动态"],margin: Adapt(40),selectIndex: self.showIndex)
        
        headerView.btnClickBlock = {[weak self] index in
            self?.showIndex = index
            self?.mainTable.reloadData()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenH - kStatuHeight - kNavigationBarHeight - kTabBarHeight - Adapt(50)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
    
}
