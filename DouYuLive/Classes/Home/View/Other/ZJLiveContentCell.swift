//
//  ZJLiveContentCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJLiveContentCell: ZJBaseTableCell {
    private lazy var mainTable : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kContentHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = kContentHeight
        tableView.register(ZJLiveListCell.self, forCellReuseIdentifier: ZJLiveListCell.identifier())
        return tableView
    }()
    
    override func zj_initWithView() {
        addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
}

// MARK: -
extension ZJLiveContentCell : UITableViewDelegate,UITableViewDataSource {
    
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
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ZJCateCollectionHeadView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(45)
    }
}
