//
//  ZJClassifyViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import SwiftyJSON

private let itemWH = kScreenW / 4

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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 列表滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY > 120 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarHidden)
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarNotHidden)
        }
    }
    
}



// MARK: - 获取分类页表数据
extension ZJClassifyViewController {
    
    private func loadCateListData() {
        
        //初始化信号量为1
        let semaphoreA = DispatchSemaphore(value: 1)
        //第二个信号量为0
        let semaphoreB = DispatchSemaphore(value: 0)
        //第三个信号量为0
        let semaphoreC = DispatchSemaphore(value: 0)
        let queue = DispatchQueue(label: "com.douyuLive.cate1.queue", qos: .utility, attributes: .concurrent)
        let mainQueue = DispatchQueue.main
        
        queue.async{
            semaphoreA.signal()
            ZJNetWorking.requestData(type: .GET, URlString: ZJLiveCateURL) { (response) in
                
                do {
                    let data = try JSONDecoder().decode(ZJCateOneList.self, from: response)
                    self.cateListData = data
                    
                }catch{}
                semaphoreB.signal()
                print("第一个任务执行完毕")
            }
        }
        
        queue.async{
            semaphoreB.wait()
            ZJNetWorking.requestData(type: .GET, URlString: ZJRecommendCategoryURL) { (response) in
                
                do {
                    let data = try JSONDecoder().decode(ZJRecommendCate.self, from: response)
                    self.recommenCateData = data
                    
                }catch{}
                
                semaphoreC.signal()
                print("第二个任务执行完毕")
            }
        }
        
        queue.async{
            
            if semaphoreC.wait(wallTimeout: .distantFuture) == .success{
                mainQueue.async {
                    print("全部任务执行完毕,刷新页面")
                    self.mainTable.reloadData()
                }
            }
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
        cell.selectionStyle = .none
        if indexPath.section == 0 {
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


