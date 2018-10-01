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
    
    
    private lazy var rankView : ZJRankView = {
        let view = ZJRankView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 3
        view.layer.shadowColor = colorWithRGBA(99, 99, 99, 1).cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    
    override func zj_initWithAllView() {
        addSubview(cycleView)
        addSubview(rankView)
        
        rankView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(Adapt(15))
            make.left.equalTo(Adapt(15))
            make.right.equalTo(Adapt(-15))
            make.height.equalTo(Adapt(65))
        }
        
        
//        let maskPath : UIBezierPath = UIBezierPath(roundedRect: self.rankView.bounds, cornerRadius: 4)
//        let maskLayer: CAShapeLayer = CAShapeLayer()
//        //设置大小
//        maskLayer.frame = self.rankView.bounds
//        //设置图形样子
//        maskLayer.path = maskPath.cgPath
//        self.rankView.layer.mask = maskLayer
//
        
    }
    
    
}


// MARK: - 遵守协议
extension ZJFishBarRecommendHeadView : ZJCycleCardViewDelegate {
    func zj_cycleCardViewDidSeletedItemAction(cycleCardView: ZJCycleCardView, index: Int) {
        print(index)
    }
}
