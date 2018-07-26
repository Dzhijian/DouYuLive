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
        self.title = ""
        
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ZJHomeViewController {
    
    // 配置 UI
    func setUpUI(){
     
        setUpNavigation()
    }
    
    // 配置 NavigationBar
    func setUpNavigation() -> Void {
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        let size = CGSize(width: 30, height: 30)
        // 左边的按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButton("home_newSaoicon","micLink_seatAreaPlaceholder",size)
        navigationItem.leftBarButtonItem = UIBarButtonItem("home_newSaoicon", "home_newSaoicon", size)
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButton("home_column_more", "home_column_more", size)
        
    }
}
