//
//  ZJClassifyViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

let itemWH = kScreenW / 4

private let CellID = "CellID"

class ZJClassifyViewController: ZJBaseViewController {

    private lazy var mainTable : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //设置 footerview 的高度为0
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = kWhite
        tableView.register(ZJCategroyListCell.self, forCellReuseIdentifier: CellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kWhite
        setUpAllView()
        // 获取分类列表数据
        loadCateListData()
        // 获取推荐分类列表数据
        loadRecommendCateItemData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY > 100 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
           
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}


extension ZJClassifyViewController {
    
    private func loadCateListData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJLiveCateURL) { (response) in
            
        }
    }
    
    
    private func loadRecommendCateItemData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJRecommendCategoryURL) { (response) in
            
        }
    }
    
}

// 配置 UI
extension ZJClassifyViewController {
    private func setUpAllView () {
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}

extension ZJClassifyViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        cell.selectionStyle = .none

        cell.backgroundColor = kWhite
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Adapt(220);
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ZJCollectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
    
    
    
}


