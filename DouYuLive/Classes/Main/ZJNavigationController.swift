//
//  ZJNavigationController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false

    }
    
    //MARK: 重写跳转
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count>0 {
            
            viewController.hidesBottomBarWhenPushed = true //跳转之后隐藏
        }
        
        
        super.pushViewController(viewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
