//
//  ZJFollowVideoViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFollowVideoViewController: ZJBaseViewController {
    
    private var videoList : [ZJFollowVideoList] = [ZJFollowVideoList]()
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = kWhite
        mainTable.separatorStyle = .none
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(ZJBaseTableCell.self, forCellReuseIdentifier: ZJBaseTableCell.identifier())
        mainTable.register(ZJVideoListCell.self, forCellReuseIdentifier: ZJVideoListCell.identifier())
        return mainTable
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kWhite
        setUpAllView()
        getVideoListData()
    }
    
}

// MARK: - 网络请求
extension ZJFollowVideoViewController {
    
    private func getVideoListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJFollowVideoURL) { (response) in
            let data = try? ZJDecoder.decode(ZJFollowVideoData.self, data: response)
            if data != nil {
                self.videoList = (data?.data)!
                self.mainTable.reloadData()
//                print(data!)
            }
        }
    }
}

// MARK: - 遵守协议
extension  ZJFollowVideoViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: ZJBaseTableCell.identifier(), for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZJVideoListCell.identifier(), for: indexPath) as! ZJVideoListCell
        cell.videoModel = self.videoList[indexPath.item]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? Adapt(100) : ZJVideoListCell.cellHeight()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ZJCollectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        header.titleLab.font = BoldFontSize(14)
        header.configTitle(title: section == 0 ? "优质 UP 主推荐" : "最热视频推荐")
        header.botLine.isHidden = true
        header.topLine.isHidden = true
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(45)
    }
    
    
    
}

// MARK: - 配置 UI
extension ZJFollowVideoViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
