//
//  ZJActivityView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJActivityView: ZJBaseView {
    
    var icon = UIImageView()
    var markLab = UILabel()
    var titleLab = UILabel()
    var descLab = UILabel()
    var btn = UIButton()
    
    
    
    
    override func zj_initWithAllView() {
        
        self.backgroundColor = kBGGrayColor
        setUpAllView()
    }
    
}



// 配置 UI 视图
extension ZJActivityView {
    
    private func setUpAllView() {
        
        icon = UIImageView.zj_createImageView(imageName: "home_header_hot", supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(10))
            make.width.height.equalTo(Adapt(24))
        })
        
        markLab = UILabel.zj_createLabel(text: "活动", textColor:  kMainTextColor, font: BoldFontSize(18), supView: self, closure: { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(Adapt(5))
            make.width.equalTo(45)
        })
        
        let line = UIView.zj_createView(bgClor: klineColor, supView: self, closure: { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.width.equalTo(0.8)
            make.height.equalTo(25)
            make.left.equalTo(markLab.snp.right).offset(Adapt(10))
        })
        
        btn = UIButton.zj_createButton(title: "预定", titleStatu: . normal, imageName: "", imageStatu: nil, supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(Adapt(-10))
            make.width.equalTo(Adapt(55))
            make.height.equalTo(Adapt(25))
        })
        btn.titleLabel?.font = FontSize(14)
        btn.setBackgroundImage(UIImage(named: "free_flow_background_1_1"), for: .normal)
        
        titleLab = UILabel.zj_createLabel(text: "小苏菲 《空心》MV首发", textColor:  kMainTextColor, font: FontSize(14), supView: self, closure: { (make) in
            make.top.equalTo(Adapt(15))
            make.left.equalTo(line.snp.right).offset(Adapt(10))
            make.right.equalTo(btn.snp.left).offset(Adapt(-10))
        })
        
         descLab = UILabel.zj_createLabel(text: "8月31日 20:00开始 1888人预定", textColor:  kGrayTextColor, font: FontSize(12), supView: self, closure: { (make) in
            make.bottom.equalTo(Adapt(-15))
            make.left.equalTo(line.snp.right).offset(Adapt(10))
            make.right.equalTo(btn.snp.left).offset(Adapt(-10))
        })
    }
}
