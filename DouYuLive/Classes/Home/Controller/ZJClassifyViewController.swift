//
//  ZJClassifyViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import SwiftyJSON
import ESPullToRefresh

private let itemWH = kScreenW / 4

private let CellID = "CellID"

class ZJClassifyViewController: ZJBaseViewController {
    var cateOneList : Array<JSON> = []
    
    private var recommenCateData : ZJRecomCateData?
//    private var recommenCateData : ZJRecommendCate = ZJRecommendCate()
    private var cateListData : [ZJCateOneData] = [ZJCateOneData]()
    
    private lazy var mainTable : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatuHeight-kTabBarHeight-kNavigationBarHeight), style: .grouped)
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
        
        ZJProgressHUD.showProgress(supView: self.mainTable, imgFrame: CGRect.zero,imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
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
            /*
            ZJNetWorking.requestData(type: .GET, URlString: ZJLiveCateURL) { (response) in

                let data = try? ZJDecoder.decode(ZJCateOneList.self, data: response)
                if data != nil {
                    self.cateListData = data!

                }
                semaphoreB.signal()
                print("第一个任务执行完毕" + "\(Thread.current)")
            }
            */
            ZJNetworkProvider.shared.requestDataWithTargetJSON(target:HomeAPI.liveCateList,  successClosure: {(response) in
                
                let jsonDict = response.dictionaryObject
                // 字典转模型
                let allData : ZJCateAllData = ZJCateAllData(JSON: jsonDict!)!
                self.cateListData = allData.cate1_list
//                print(allData)
                semaphoreB.signal()
                print("第一个任务执行完毕" + "\(Thread.current)")
                
            }, failClosure: {_ in
                
            })
        }
        
        queue.async{
            semaphoreB.wait()
            /*
            ZJNetWorking.requestData(type: .GET, URlString: ZJRecommendCategoryURL) { (response) in

                let data = try? ZJDecoder.decode(ZJRecommendCate.self, data: response)
                if data != nil {
                    self.recommenCateData = data!
                }
                semaphoreC.signal()
                print("第二个任务执行完毕" + "\(Thread.current)" )
            }
            */
            
            // Moya + ObjectMapper + Alamofire 实现网络请求
            ZJNetworkProvider.shared.requestDataWithTargetJSON(target:HomeAPI.recommendCategoryList,  successClosure: {(response) in
                let jsonDict = response.dictionaryObject
                // response.dictionaryObject json 转字典
                // 字典转模型
                let cate : ZJRecomCateData = ZJRecomCateData(JSON: jsonDict!)!
                print(cate.cate2_list.count)
                self.recommenCateData = cate
                semaphoreC.signal()
            }, failClosure: {_ in
                
            })
        }
        
        queue.async{
            if semaphoreC.wait(wallTimeout: .distantFuture) == .success{
                mainQueue.async {
                    self.mainTable.es.stopPullToRefresh()
                    ZJProgressHUD.hideAllHUD()
                    print("全部任务执行完毕,刷新页面" + "\(Thread.current)")
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
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = ZJRefreshView(frame: CGRect.zero)
        
        self.mainTable.es.addPullToRefresh(animator: header) { [weak self] in
            self?.loadCateListData()
        }
    }
    
    
}

extension ZJClassifyViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1 + (self.cateListData.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! ZJCategroyListCell
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.cateTwoList = self.recommenCateData?.cate2_list
        }else{
            if self.cateListData.count != 0 {
                let item : ZJCateOneData = self.cateListData[indexPath.section - 1]
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
            if self.cateListData.count != 0 {
                let item : ZJCateOneData = self.cateListData[section - 1]
                header.configTitle(title:item.cate_name!)
            }
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
    
    
    
}


