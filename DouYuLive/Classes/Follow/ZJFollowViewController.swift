//
//  ZJFollowViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kFollowCateH : CGFloat = Adapt(50)
class ZJFollowViewController: ZJBaseViewController {

    // 标题数组
    private lazy var titles : [String] = ["直播","视频","动态"]
    // 控制器数组
    private lazy var controllers : [UIViewController] = {
        let controllers = [ZJFollowLiveViewController(),ZJFollowVideoViewController(),ZJFollowStateViewController()]
        return controllers
    }()
    // 标题View
    private lazy var pageTitleView : ZJPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kFollowCateH)
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
        let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kFollowCateH - kTabBarHeight
        let frame = CGRect(x: 0, y: kFollowCateH, width: kScreenW, height: height)
        
        let contentView = ZJPageContentView(frame: frame, childVCs: controllers, parentViewController:self!)
        contentView.delegate = self
        return contentView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 遵守协议
extension ZJFollowViewController : PageTitleViewDelegate,PageContentViewDelegate {
    
    func pageTitleView(titleView: ZJPageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
    }
    
    func pageContentView(contentView: ZJPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

// MARK: - 配置 UI
extension ZJFollowViewController {
    
    private func setUpAllView() {
        // 添加 TitleView
        view.addSubview(pageTitleView)
        // 添加 ContentView
        view.addSubview(pageContenView)
        
        setUpNavigation()
    }
    
}
