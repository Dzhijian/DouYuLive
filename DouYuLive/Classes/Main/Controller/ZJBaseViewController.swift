//
//  ZJBaseViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJBaseViewController: UIViewController {
    
    // 状态栏的背景色
    lazy var  statuView : UIView = {
        let view = UIView()
        view.backgroundColor = kMainOrangeColor;
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kStatuHeight)
        // 设置背景渐变
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kWhite
        automaticallyAdjustsScrollViewInsets = false
        
      
        // Do any additional setup after loading the view.
//        setStatusBarBackgroundColor()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 配置 NavigationBar
    func setUpNavigation(){
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // 左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_user_normal"), style:.done ,target: self, action: #selector(self.leftItemClick))
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "viewHistoryIcon"), style:.done, target: self, action: #selector(self.rightItemClick)) //UIBarButtonItem.createBarButton("search_history", "search_history", size)
        
        let searchView  = ZJHomeSearchView()
        searchView.layer.cornerRadius = 5
        searchView.backgroundColor = kSearchBGColor
        navigationItem.titleView = searchView
        searchView.snp.makeConstraints { (make) in
            make.center.equalTo((navigationItem.titleView?.snp.center)!)
            make.width.equalTo(AdaptW(230))
            make.height.equalTo(33)
        }
    }
    
    @objc func rightItemClick() {
//        print("rightItem click")
//        self.navigationController?.pushViewController(ZJHistoryRecordViewController(), animated: true)
    }
    
    @objc func leftItemClick() {
        self.navigationController?.pushViewController(ZJProfileViewController(), animated: true)
        print("leftItem Click")
    }
    
    deinit {
        
    }
}
