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
        self.navigationController?.navigationBar.barTintColor = MainOrangeColor
        
        let size = CGSize(width: 30, height: 30)
        // 左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(norImageName: "home_newSaoicon", size: size)
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButton("home_column_more", "home_column_more", size)
        
        let searchView  = ZJHomeSearchView()
        searchView.backgroundColor = SearchBGColor
        navigationItem.titleView = searchView
        searchView.snp.makeConstraints { (make) in
            make.center.equalTo((navigationItem.titleView?.snp.center)!)
            make.width.equalTo(250)
            make.height.equalTo(35)
        }
        
        
    }
    
    
    func setUpPageTitleView() {
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
    
        let pageTitleViw = ZJPageTitleView(frame: frame, titles: ["1","2","3","4"])
        pageTitleViw.backgroundColor = UIColor.red
        self.view.addSubview(pageTitleViw)
        
    }
}
