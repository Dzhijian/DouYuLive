//
//  ZJTabBarController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllViewController()
        
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        //self.tabBar.barTintColor = UIColor.orange
//        self.tabBar.backgroundColor = UIColor.white
        
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        
        // 设置图片和文字选中时的颜色   必须设置（系统默认选中蓝色）
        self.tabBar.tintColor = UIColor.orange
        self.tabBar.isTranslucent = false

    }
    
    // 添加所有控件
    func setUpAllViewController() -> Void {
        setUpChildController(ZJHomeViewController(), "推荐","tabLive","tabLiveHL")
        setUpChildController(ZJRecreationViewController(), "娱乐",  "tabYule",  "tabYuleHL")
        setUpChildController(ZJFollowViewController(), "关注",  "tabFocus",  "tabFocusHL")
        setUpChildController(ZJFishBarViewController(), "鱼吧",  "tabYuba",  "tabYubaHL")
        setUpChildController(ZJDiscoverViewController(), "发现",  "tabDiscovery",  "tabDiscoveryHL")
        
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
    
        
    }
    
    // 设置子控件属性
    private func setUpChildController(_ controller : UIViewController,_ title : String,_ norImage : String,_ selectedImage : String){
        
        controller.tabBarItem.title = "首页"
        // 修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
        controller.tabBarItem.image = UIImage(named: norImage)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        // 设置 NavigationController
        let nav = ZJNavigationController(rootViewController: controller)
        controller.title = title
        self.addChildViewController(nav)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
