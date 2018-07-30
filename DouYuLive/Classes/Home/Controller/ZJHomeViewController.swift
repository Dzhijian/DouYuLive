//
//  ZJHomeViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class ZJHomeViewController: ZJBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK - 配置子控件
extension ZJHomeViewController {
    
    
    // 配置 UI
    func setUpUI(){
     
        setUpNavigation()
        
        setUpPageTitleView()
    }
    
    // 配置 NavigationBar
    func setUpNavigation() -> Void {
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = MainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white

        let size = CGSize(width: 30, height: 30)
        // 左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(norImageName: "home_newSaoicon", size: size)
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_history"), style:.done, target: self, action: #selector(self.rightItemClick)) //UIBarButtonItem.createBarButton("search_history", "search_history", size)
        
        let searchView  = ZJHomeSearchView()
        searchView.layer.cornerRadius = 5
        searchView.backgroundColor = SearchBGColor
        navigationItem.titleView = searchView
        searchView.snp.makeConstraints { (make) in
            make.center.equalTo((navigationItem.titleView?.snp.center)!)
            make.width.equalTo(AdaptW(230))
            make.height.equalTo(33)
        }
        
        
    }
    
    func setUpPageTitleView() {
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
        let pageTitleViw = ZJPageTitleView(frame: frame, titles: ["1","2","3","4"])
        pageTitleViw.backgroundColor = UIColor.red
        self.view.addSubview(pageTitleViw)
        
    }
    
    @objc func rightItemClick() {
        print("rightItem cLick")
    }
    
    
  
}
