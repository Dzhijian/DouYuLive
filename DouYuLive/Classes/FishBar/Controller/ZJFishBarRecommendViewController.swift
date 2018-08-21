//
//  ZJFishBarRecommendViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/17.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFishBarRecommendViewController: ZJBaseViewController {
   
    private lazy var headView : ZJFishBarRecommendHeadView = {
        let headView = ZJFishBarRecommendHeadView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(250)))
        headView.backgroundColor = kWhite
        return headView
    }()
    
    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .plain)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = kWhite
        mainTable.separatorStyle = .none
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(ZJBaseTableCell.self, forCellReuseIdentifier: ZJBaseTableCell.identifier())
        return mainTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
        
    }
}

// MARK: - 遵守协议
extension ZJFishBarRecommendViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZJBaseTableCell.identifier(), for: indexPath)
        cell.contentView.backgroundColor = kOrange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Adapt(60)
    }
   
}

// 配置 UI 视图
extension ZJFishBarRecommendViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        mainTable.tableHeaderView = headView
    }
    
}
