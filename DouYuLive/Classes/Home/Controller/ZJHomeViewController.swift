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


// 记录导航栏是否隐藏
private var isNavHidden : Bool = false
class ZJHomeViewController: ZJBaseViewController {
    
    private lazy var  topView : UIView = {
        let view = UIView()
        view.backgroundColor = kMainOrangeColor;
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 20)
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
    
    private lazy var titles : [String] = ["分类","推荐","全部","LoL","绝地求生","王者荣耀","QQ飞车"]
    private lazy var pageTitleView : ZJPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
        let pageTitleViw = ZJPageTitleView(frame: frame, titles: titles)
        pageTitleViw.delegate = self
        return pageTitleViw
    }()
    
    private lazy var pageContenView : ZJPageContentView = { [weak self] in
        let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
        let frame = CGRect(x: 0, y: 40, width: kScreenW, height: height)
        var childVCs : [UIViewController] =  [ZJClassifyViewController(),ZJRecommendViewController(),ZJAllViewController(),ZJLOLViewController(),ZJJDQSViewController(),ZJWZRYViewController(),ZJQQCarViewController()]
        let contentView = ZJPageContentView(frame: frame, childVCs: childVCs, parentViewController:self!)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        setUpUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshNavBar), name: NSNotification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil)
    }

    @objc func refreshNavBar(noti:Notification) {
        
        
        let isHidden : String = noti.userInfo!["isHidden"] as! String
        if isHidden == "true" {
            if isNavHidden { return }
            isNavHidden = true
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: kStatuHeight, width: kScreenW, height: kCateTitleH)
                let height : CGFloat = kScreenH - kStatuHeight - kCateTitleH - kTabBarHeight
                let frame = CGRect(x: 0, y: kCateTitleH + kStatuHeight, width: kScreenW, height: height)
                self.pageContenView.frame = frame
                // 刷新 contentView Frame
                self.pageContenView.refreshColllectionView(height:self.pageContenView.frame.size.height)
            }
        }else{
            if !isNavHidden { return }
            isNavHidden = false
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
                let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
                let frame = CGRect(x: 0, y: kCateTitleH, width: kScreenW, height: height)
                self.pageContenView.frame = frame
            }
           
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}




// MARK: - 遵守PageTitleViewDelegate协议
extension ZJHomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: ZJPageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
    }
}


// MARK: - 遵守PageContentViewDelegate协议
extension ZJHomeViewController : PageContentViewDelegate{
    
    func pageContentView(contentView: ZJPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}



// MARK - 配置子控件
extension ZJHomeViewController {
    
    // 配置 UI
    func setUpUI(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // 不需要调整 scrollview 的内边距
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(topView)
        // 添加导航栏
        setUpNavigation()
        // 添加标题栏
        setUpPageTitleView()
        
        
        // 添加 ContentView
        view.addSubview(pageContenView)
    }
    
    // 配置 NavigationBar
    func setUpNavigation() -> Void {
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white

        let size = CGSize(width: 30, height: 30)
        // 左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(norImageName: "btn_user_normal", size: size)
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
    
    func setUpPageTitleView() {
        
        self.view.addSubview(pageTitleView)
        
    }
    
    @objc func rightItemClick() {
        print("rightItem cLick")
    }
    
    
}




