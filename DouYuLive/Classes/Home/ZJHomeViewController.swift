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
    
    // 标题数组
    private lazy var titles : [String] = ["分类","推荐","全部","LoL","绝地求生","王者荣耀","QQ飞车"]
    // 控制器数组
    private lazy var controllers : [UIViewController] = {
        let controllers = [ZJClassifyViewController(),ZJRecommendViewController(),ZJAllViewController(),ZJLOLViewController(),ZJJDQSViewController(),ZJWZRYViewController(),ZJQQCarViewController()]
        return controllers
    }()
    // 标题View
    private lazy var pageTitleView : ZJPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
        let option = ZJPageOptions()
        option.kGradColors = kGradientColors
        option.kBotLineColor = kWhite
        option.kNormalColor = (220,220,220)
        option.kSelectColor = (250,250,250)
        option.kTitleSelectFontSize = 14
        option.isShowBottomLine = false
        option.kIsShowBottomBorderLine = false
        let pageTitleViw = ZJPageTitleView(frame: frame, titles: titles ,options:option)
        pageTitleViw.delegate = self
        return pageTitleViw
    }()
    // 内容 View
    private lazy var pageContenView : ZJPageContentView = { [weak self] in
        let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
        let frame = CGRect(x: 0, y: kCateTitleH, width: kScreenW, height: height)
        
        let contentView = ZJPageContentView(frame: frame, childVCs: controllers, parentViewController:self!)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshNavBar), name: NSNotification.Name(rawValue: ZJNotiRefreshHomeNavBar), object: nil)
    }

    // MARK: 导航栏隐藏与显示
    @objc func refreshNavBar(noti:Notification) {
        
        let isHidden : String = noti.userInfo!["isHidden"] as! String
        if isHidden == "true" {
            if isNavHidden { return }
            isNavHidden = true
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: kStatuHeight, width: kScreenW, height: kCateTitleH)
                let height : CGFloat = kScreenH - kStatuHeight - kCateTitleH - kTabBarHeight
                let frame = CGRect(x: 0, y: kCateTitleH + kStatuHeight, width: kScreenW, height: height)
                self.pageContenView.frame = frame
                self.pageContenView.refreshColllectionView(height:self.pageContenView.frame.size.height)
                
            }
        }else{
            if !isNavHidden { return }
            isNavHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCateTitleH)
                let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
                let frame = CGRect(x: 0, y: kCateTitleH, width: kScreenW, height: height)
                self.pageContenView.frame = frame
            }
           
        }
    }
}




// MARK: - 遵守PageTitleViewDelegate,PageContentViewDelegate协议
extension ZJHomeViewController : PageTitleViewDelegate,PageContentViewDelegate {
    
    func pageTitleView(titleView: ZJPageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
    }
    
    func pageContentView(contentView: ZJPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



// MARK - 配置子控件
extension ZJHomeViewController {
    
    // 配置 UI
    func setUpAllView(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // 不需要调整 scrollview 的内边距
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(statuView)
        // 添加导航栏
        setUpNavigation()
        // 添加标题栏
        setUpPageTitleAndContentView()
        
        
    }
    
    func setUpPageTitleAndContentView() {
        // 添加 TitleView
        view.addSubview(pageTitleView)
        // 添加 ContentView
        view.addSubview(pageContenView)
        
    }
    
    
    
}




