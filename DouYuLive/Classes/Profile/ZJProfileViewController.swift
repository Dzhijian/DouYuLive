//
//  ZJProfileViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/22.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJProfileViewController: ZJBaseViewController {

    private let titles : [[String]] = [["我的等级","我的空间","我的粉丝徽章","小姐姐特权","我的积分"],
                                     ["游戏中心","我的竞猜","金牌玩家"],
                                     ["主播招募","排行榜"],
                                     ["我的视频","视频收益","视频收藏"],
                                     ["我的账户","免流量特权"],
                                     ["关注管理","开播提醒"]]
    private let icons : [[String]] = [["icon_my_level","icon_myzone","icon_fans_badge","icon_little_sister","icon_point"],
                                       ["icon_gamecenter","icon_guess","icon_accompany"],
                                       ["icon_anchor_recruit","icon_rank_morefrag"],
                                       ["icon_my_video","icon_video_income","icon_collection"],
                                       ["icon_account","icon_free"],
                                       ["icon_focus","icon_remind"]]
    
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .grouped)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(ZJProfileCell.self, forCellReuseIdentifier: ZJProfileCell.identifier())
        mainTable.separatorStyle = .none
        mainTable.estimatedSectionHeaderHeight = 0
        mainTable.estimatedSectionFooterHeight = 0
        mainTable.estimatedRowHeight = 0
        mainTable.backgroundColor = kBGGrayColor
        return mainTable
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
    }


}


// 配置 UI 视图
extension ZJProfileViewController : UITableViewDelegate,UITableViewDataSource{
    
    private func setUpAllView() {
//        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZJProfileCell.identifier(), for: indexPath) as! ZJProfileCell
        
        cell.icon.image = UIImage(named:self.icons[indexPath.section][indexPath.row])
        cell.titleLab.text = self.titles[indexPath.section][indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Adapt(45)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = kBGGrayColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(10)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
