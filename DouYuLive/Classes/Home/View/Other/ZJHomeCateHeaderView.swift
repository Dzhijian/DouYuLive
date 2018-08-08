//
//  ZJHomeCateHeaderView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import SBCycleScrollView

class ZJHomeCateHeaderView: ZJBaseView {

     lazy var cycleScrollView : CycleScrollView = {
        let frame : CGRect = self.bounds
        var option = CycleOptions()
        option.currentPageDotColor = kMainOrangeColor
        option.radius = 4
        option.pageAliment = .right
        option.rightOffset = 20
        option.pageStyle = PageControlStyle.jaloro
        let cycleScrollView = CycleScrollView.initScrollView(frame: frame, delegate: self, placehoder: UIImage.init(named: "place.png"), cycleOptions: option)
        cycleScrollView.imageNamesGroup = ["liveImage","liveImage","liveImage"]
        cycleScrollView.titlesGroup = ["  哈哈哈","  呵呵呵","   嘿嘿嘿"]
        
        return cycleScrollView
    }()
    
    override func zj_initWithAllView() {
        setUpAllView()
    }
    
    func configBnanerList(bannerList : [ZJBannerList]) {
        var imageUrlArr : [String] = Array<String>()
        var titleArr : [String] = Array<String>()
        for item in bannerList {
            imageUrlArr.append(item.resource!)
            titleArr.append(item.title!)
        }
        cycleScrollView.imageURLStringsGroup = imageUrlArr
        cycleScrollView.titlesGroup = titleArr
        
    }

}


// MARK: - CycleScrollViewDelegate 代理方法
extension ZJHomeCateHeaderView : CycleScrollViewDelegate {
    
    
    func didSelectedCycleScrollView(_ cycleScrollView: CycleScrollView, _ Index: NSInteger) {
        print("点击了第\(Index)张图片")
    
    }
    
}

// 配置 UI 视图
extension ZJHomeCateHeaderView  {
    
    private func setUpAllView() {
        addSubview(cycleScrollView)
        

    }
}
