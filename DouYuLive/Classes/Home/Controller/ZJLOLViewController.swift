//
//  ZJLOLViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJLOLViewController: ZJBaseViewController {

    private lazy var mainTable : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = kWhite
        tableView.register(ZJLiveListCell.self, forCellReuseIdentifier: ZJLiveListCell.identifier())
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// 配置 UI 视图
extension ZJLOLViewController {
    
    private func setUpAllView() {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
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
        return 500
    }
}
