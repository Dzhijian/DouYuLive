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
        tableView.register(ZJCategroyListCell.self, forCellReuseIdentifier: ZJCategroyListCell.identifier())
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kWhite
        setUpAllView()
        // 获取分类列表数据
        loadCateListData()
        
        ZJProgressHUD.showProgress(supView: self.view, bgFrame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kStatuHeight-kTabBarHeight-kNavigationBarHeight),imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
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
        
        queue.async{
            semaphoreA.signal()

            ZJNetworkProvider.shared.requestDataWithTargetJSON(target:HomeAPI.liveCateList,  successClosure: {(response) in
                guard let jsonDict = response.dictionaryObject else {
                    semaphoreB.signal()
                    return
                }
                // 字典转模型
                let allData : ZJCateAllData = ZJCateAllData(JSON: jsonDict)!
                self.cateListData = allData.cate1_list
                semaphoreB.signal()
                
            }, failClosure: {_ in
                 semaphoreB.signal()
            })
        }
        
        queue.async{
            semaphoreB.wait()

            // Moya + ObjectMapper + Alamofire 实现网络请求
            ZJNetworkProvider.shared.requestDataWithTargetJSON(target:HomeAPI.recommendCategoryList,  successClosure: {(response) in
                guard let jsonDict = response.dictionaryObject else {
                    semaphoreC.signal()
                    return
                }
                // 字典转模型
                let cate : ZJRecomCateData = ZJRecomCateData(JSON: jsonDict)!
                self.recommenCateData = cate
                semaphoreC.signal()
            }, failClosure: {_ in
                semaphoreC.signal()
            })
        }
        
        queue.async{
            if semaphoreC.wait(wallTimeout: .distantFuture) == .success{
                DispatchQueue.main.async {
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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZJCategroyListCell.identifier(), for: indexPath) as! ZJCategroyListCell
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
        guard self.cateListData.count != 0 else { return 0 }
        let maxItemCount = 8
        let pageControlHeight: CGFloat = 37
        let spaceHeight: CGFloat = 10   //没有pageControl时添加
        var dataCount = 0   // item的数量
        
        if indexPath.section == 0 {
            let model = self.recommenCateData?.cate2_list ?? []
            dataCount = model.count
        } else {
            let model = self.cateListData[indexPath.section - 1].cate2_list
            dataCount = model.count
        }
        
        // 根据item个数计算cell高度
        if dataCount > maxItemCount {
            return CateItemHeight * 2 + pageControlHeight
        } else if dataCount > 4 && dataCount <= maxItemCount {
            return CateItemHeight * 2 + spaceHeight
        } else {
            return CateItemHeight + spaceHeight
        }
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
        header.topLine.isHidden = true
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
    
    
    
}


