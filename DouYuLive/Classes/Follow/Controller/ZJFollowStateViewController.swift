//
//  ZJFollowStateViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFollowStateViewController: ZJBaseViewController {

    private lazy var mainTable : UITableView = {
        let mainTable = UITableView(frame: CGRect.zero, style: .plain)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.backgroundColor = kWhite
        mainTable.separatorStyle = .none
        mainTable.register(ZJBaseTableCell.self, forCellReuseIdentifier: ZJBaseTableCell.identifier())
        return mainTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kBlue
        setUpAllview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 遵守协议
extension ZJFollowStateViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: ZJBaseTableCell.identifier(), for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
  
}

// MARK: - 配置 UI
extension ZJFollowStateViewController {
    
    private func setUpAllview() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}


