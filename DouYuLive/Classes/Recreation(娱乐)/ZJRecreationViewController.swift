//
//  ZJRecreationViewController.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/25.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJRecreationViewController: ZJBaseViewController {

    // 分类数据
    private lazy var cateListData : ZJRecreationCateData = ZJRecreationCateData()
    
    // 标题数组
    private lazy var titles : [String] = {
        var titles : [String] = ["推荐"]
        for (index,item) in cateListData.data.enumerated() {
            titles.append(item.cate_name!)
        }
        return titles
    }()
    
    // 控制器数组
    private lazy var controllers : [UIViewController] = {
        let controllers = [ZJRecreationRecommendViewController(),ZJFaceScoreViewController(),ZJOutdoorsViewController(),ZJQQCarViewController(),ZJMusicViewController()]
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
        
        let pageTitleViw = ZJPageTitleView(frame: frame, titles: titles ,options:option)
        pageTitleViw.delegate = self
        return pageTitleViw
        }()
    // 内容 View
    private lazy var pageContenView : ZJPageContentView = { [weak self] in
        let height : CGFloat = kScreenH - kStatuHeight - kNavigationBarHeight - kCateTitleH - kTabBarHeight
        let frame = CGRect(x: 0, y: 40, width: kScreenW, height: height)
        
        let contentView = ZJPageContentView(frame: frame, childVCs: controllers, parentViewController:self!)
        contentView.delegate = self
        return contentView
        }()
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpNavigation()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = kWhite
        
        ZJProgressHUD.showProgress(supView: self.view, bgFrame: nil,imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
        
        loadChildCateListData()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

// MARK: - 遵守PageTitleViewDelegate,PageContentViewDelegate协议
extension ZJRecreationViewController : PageTitleViewDelegate,ZJPageContentViewDelegate {
    
    func pageTitleView(titleView: ZJPageTitleView, selectedIndex index: Int) {
        pageContenView.setCurrentIndex(currentIndex: index)
    }
    
    func zj_pageContentView(contentView: ZJPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

// MARK: - 网络请求
extension ZJRecreationViewController {
    
    // 获取子类分类数据
    private func loadChildCateListData() {
        
        ZJNetWorking.requestData(type: .GET, URlString: RecreationChildCateURL) { (response) in
            let data = try? ZJDecoder.decode(ZJRecreationCateData.self, data : response)
            if data != nil {
               self.cateListData = data!
                ZJProgressHUD.hideAllHUD()
                self.setUpAllView()
            }
        }
    }
}

// MARK: - 配置 UI
extension ZJRecreationViewController {
    
    private func setUpAllView() {
        
        // 添加 pageTitleView
        view.addSubview(pageTitleView)
        // 添加 ContentView
        view.addSubview(pageContenView)
        
       
    }
    
    
    
    
}





