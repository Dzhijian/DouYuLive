//
//  ZJFollowLiveViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFollowLiveViewController: ZJBaseViewController {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenH
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
    }
}
