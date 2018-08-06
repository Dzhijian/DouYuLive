//
//  ZJClassifyViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import SwiftyJSON

let itemWH = kScreenW / 4

private let CellID = "CellID"

class ZJClassifyViewController: ZJBaseViewController {
    var cateOneList : Array<JSON> = []
    
    private var recommenCateData : ZJRecommendCate = ZJRecommendCate()
    private var cateListData : ZJCateOneList = ZJCateOneList()
    
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

            do {
                let data = try JSONDecoder().decode(ZJCateOneList.self, from: response)
                
                self.cateListData = data
                self.mainTable.reloadData()
                
            }catch{}
        }

    }
    
    
    private func loadRecommendCateItemData() {
        ZJNetWorking.requestData(type: .GET, URlString: ZJRecommendCategoryURL) { (response) in
            do {
                let data = try JSONDecoder().decode(ZJRecommendCate.self, from: response)
                self.recommenCateData = data
                self.mainTable.reloadData()
            }catch{}
            
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
        
        return 1 + (self.cateListData.cate1_list.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ZJCategroyListCell
        if indexPath.section == 0 {
//            cell.pageControl.isHidden = true
            cell.cateTwoList = self.recommenCateData.cate2_list
        }else{
            if self.cateListData.cate1_list.count != 0 {
                let item : ZJCateOneItem = self.cateListData.cate1_list[indexPath.section - 1]
                cell.cateTwoList = item.cate2_list
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if indexPath.section == 0 {
//            return CateItemHeight * 2
//        }
        return Adapt(220);
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ZJCollectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(50)))
        if section == 0 {
            header.configTitle(title: "推荐分类")
        }else{
            if self.cateListData.cate1_list.count != 0 {
                let item : ZJCateOneItem = self.cateListData.cate1_list[section - 1]
                header.configTitle(title:item.cate_name!)
            }
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
    
    
    
}


