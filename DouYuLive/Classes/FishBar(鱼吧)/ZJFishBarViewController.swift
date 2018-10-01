//
//  ZJFishBarViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
private let kFishBarCateH : CGFloat = Adapt(50)
class ZJFishBarViewController: ZJBaseViewController {

    // 标题数组
    private lazy var titles : [String] = ["推荐","我的","热门"]
    // 控制器数组
    private lazy var controllers : [UIViewController] = {
        let controllers = [ZJFishBarRecommendViewController(),ZJFishBarMineViewController(),ZJFishBarHotViewController()]
        return controllers
    }()
    // 标题View
    private lazy var pageTitleView : ZJPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kFishBarCateH)
        let option = ZJPageOptions()
        option.kIsNormalFontBold = true
        option.kBotLineColor = kWhite
        option.kNormalColor = (33,33,33)
        option.kSelectColor = (223,106,70)
        option.kTitleFontSize = 16
        option.kItemWidth = Adapt(80)
        option.isTitleScrollEnable = false
        option.isShowBottomLine = false
        option.kIsShowBottomBorderLine = false
        let pageTitleViw = ZJPageTitleView(frame: frame, titles: titles ,options:option)
        pageTitleViw.delegate = self
        return pageTitleViw
        }()
    // 内容 View
    private lazy var pageContenView : ZJPageContentView = { [weak self] in
        let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kFishBarCateH - kTabBarHeight
        let frame = CGRect(x: 0, y: kFishBarCateH, width: kScreenW, height: height)
        
        let contentView = ZJPageContentView(frame: frame, childVCs: controllers, parentViewController:self!)
        contentView.delegate = self
        return contentView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllView()
    }
}

// MARK: - 遵守协议
extension ZJFishBarViewController : PageTitleViewDelegate, ZJPageContentViewDelegate {
    
    func pageTitleView(titleView: ZJPageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
    }
    
    func zj_pageContentView(contentView: ZJPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

// MARK: - 配置 UI
extension ZJFishBarViewController {
    
    private func setUpAllView() {
        // 添加 TitleView
        view.addSubview(pageTitleView)
        // 添加 ContentView
        view.addSubview(pageContenView)
        
        setUpNavigation()
    }
}
