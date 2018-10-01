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
    
    // 头部视图
    private lazy var headerView : ZJProfileHeadView = {
        let headView  = ZJProfileHeadView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(240)))
        headView.deleagte = self
        return headView
    }()
    
    // 登录弹窗
    private lazy var loginView : ZJPopLoginView = {
        let loginView = ZJPopLoginView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
        loginView.delegate = self
        return loginView
    }()
    
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
        
    
        // 显示加载动画
        ZJProgressHUD.showProgress(supView: UIApplication.shared.keyWindow!, bgFrame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH),imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
        
        // 延迟1秒隐藏加载动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ZJProgressHUD.hideAllHUD()
        }

    }


}

// 配置 UI 视图
extension ZJProfileViewController : ZJPopLoginViewDelegate {
    func zj_goToLoginVC() {
        let nav = ZJNavigationController(rootViewController: ZJLoginViewController())
        self.present(nav, animated: true, completion: nil)
    }
    
    func zj_goToRegisterVC() {
        
        let nav = ZJNavigationController(rootViewController: ZJRegisterViewController())
        self.present(nav, animated: true, completion: nil)
    }
}

// MARK: - ZJProfileHeadViewDelegate
extension ZJProfileViewController : ZJProfileHeadViewDelegate {
    
    func zj_loginBtnAction(sender: UIButton) {
        UIApplication.shared.keyWindow?.addSubview(self.loginView)
        self.loginView.zj_showLoginView()
    }
}

// MARK: -
extension ZJProfileViewController {
    
    @objc private func leftItemBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func activityAction() {
        print("activityAction")
    }
    @objc private func settingAction() {
        print("settingAction")
    }
}

// 遵守协议
extension ZJProfileViewController : UITableViewDelegate,UITableViewDataSource{
    
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
        cell.selectionStyle = .default
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Adapt(50)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = kBGGrayColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainTable.deselectRow(at: indexPath, animated: true)
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


// 配置 UI 视图
extension ZJProfileViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headerView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_nav_back"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(self.leftItemBackClick))
        
        
        //直播按钮
        let liveBtn = UIButton(frame:CGRect(x:0, y:0, width:20, height:20))
        liveBtn.setImage(UIImage(named: "icon_nav_dycard"), for: .normal)
        liveBtn.addTarget(self,action:#selector(self.leftItemBackClick),for:.touchUpInside)
        let barButton1 = UIBarButtonItem(customView: liveBtn)
        
        //设置按钮
        let setBtn = UIButton(frame:CGRect(x:0, y:0, width:20, height:20))
        setBtn.setImage(UIImage(named: "Image_headerView_settings"), for: .normal)
        setBtn.addTarget(self,action:#selector(self.settingAction),for:.touchUpInside)
        let barButton2 = UIBarButtonItem(customView: setBtn)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 15
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [spacer,barButton2,gap,barButton1]
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

    }
    
}
