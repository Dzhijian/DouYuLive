//
//  ZJCycleCardItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/21.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCycleCardItem: ZJBaseCollectionCell {
    
    // 圆角大小
    var cornerRadius : CGFloat = 0.0
    
    lazy var imgView : UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = kBGGrayColor
        return imgV
    }()
    
    override func zj_setUpAllView() {
        contentView.addSubview(imgView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgView.frame = self.bounds
        
        let maskPath : UIBezierPath = UIBezierPath(roundedRect: self.imgView.bounds, cornerRadius: self.cornerRadius)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        //设置大小
        maskLayer.frame = self.bounds
        //设置图形样子
        maskLayer.path = maskPath.cgPath
        imgView.layer.mask = maskLayer
        
    }
}
