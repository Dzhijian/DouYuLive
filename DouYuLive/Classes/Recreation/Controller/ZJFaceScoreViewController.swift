//
//  ZJFaceScoreViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/15.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

// MARK: 颜值
class ZJFaceScoreViewController: ZJBaseViewController {

    var faceScoreHotData : ZJLiveListData = ZJLiveListData()
    
    private lazy var showIndex : Int = 0
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .plain)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = kWhite
        mainTable.separatorStyle = .none
        mainTable.bounces = false
        mainTable.showsHorizontalScrollIndicator = false
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(ZJFaceScoreCell.self, forCellReuseIdentifier: ZJFaceScoreCell.identifier())
        return mainTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllView()
        
        getFaceScoreHostListData()
        getFaceScoreNearlybyListData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

// MARK: - 网络请求,加载数据
extension ZJFaceScoreViewController {
    
    // 获取热门数据列表
    private func getFaceScoreHostListData() {
        
        ZJNetWorking.requestData(type: .GET, URlString: ZJFaceScoreListHotURL) { (response) in
            
            let data = try? ZJDecoder.decode(ZJLiveListData.self, data : response)
            if data != nil {
                self.faceScoreHotData = data!
                self.mainTable.reloadData()
            }
        }
    }
    
    // 获取热门数据列表
    private func getFaceScoreNearlybyListData() {
        
        let time:Int = Int(NSDate().timeIntervalSince1970)
        
        
        let urlStr = "\(ZJFaceScoreListNearURL)" + "&latitude=22.547960&limit=20&longitude=113.956170&offset=0&time=\(time)&auth=a641e9783ca81e2c954e0deb383416e9"
        
        ZJNetWorking.requestData(type: .GET, URlString: urlStr) { (response) in

            let data = try? ZJDecoder.decode(ZJLiveListData.self, data : response)
            if data != nil {
                self.faceScoreHotData = data!
                self.mainTable.reloadData()
            }
        }
    }
}

// MARK: - 遵守协议
extension ZJFaceScoreViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZJFaceScoreCell.identifier(), for: indexPath) as! ZJFaceScoreCell
        
        if self.faceScoreHotData.list.count > 0 {
            cell.faceScoreDataList = self.faceScoreHotData.list
        }
        
        cell.contentView.backgroundColor = kPurple
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ZJCateSectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        headerView.setUpTitles(titles: ["看热门","看附近"],margin: Adapt(40),selectIndex: self.showIndex)
        
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
// MARK: - 添加 UI
extension ZJFaceScoreViewController{
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
