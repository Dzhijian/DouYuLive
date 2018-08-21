//
//  ZJFishBarRecommendHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/19.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFishBarRecommendHeadView: ZJBaseView {
    
    private lazy var cycleView : ZJCycleCardView = {
        let style = ZJCycleViewStyle()
        let cycleView = ZJCycleCardView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: Adapt(150)), imageArray: ["liveImage","liveImage","liveImage"], style: style)
        cycleView.backgroundColor = kWhite
        cycleView.delegate = self
        return cycleView
    }()
    
    
    private lazy var rankView : UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func zj_initWithAllView() {
        addSubview(cycleView)
    }
    
    
}


// MARK: - 遵守协议
extension ZJFishBarRecommendHeadView : ZJCycleCardViewDelegate {
    func zj_cycleCardViewDidSeletedItemAction(cycleCardView: ZJCycleCardView, index: Int) {
        print(index)
    }
}
