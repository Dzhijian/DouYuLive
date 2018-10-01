//
//  ZJDiscoverCateItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/17.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJDiscoverCateItem: ZJBaseCollectionCell {
    
    private lazy var imageV : UIImageView = UIImageView()
    private lazy var titleLab : UILabel = UILabel()
    
    
    
    override func zj_initWithView() {
        setUpAllView()
    }
    
    func configItem(title : String , imageName : String) {
        self.titleLab.text = title
        self.imageV.image = UIImage(named: imageName)
    }
    
}

// 配置 UI 视图
extension ZJDiscoverCateItem {
    
    private func setUpAllView() {
        self.imageV = UIImageView.zj_createImageView(imageName: "", supView: self.contentView, closure: { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(Adapt(10))
            make.width.height.equalTo(Adapt(50))
        })
        
        self.titleLab = UILabel.zj_createLabel(text: "测试", textColor: kGrayTextColor, font: FontSize(12), supView: self.contentView, closure: { (make) in
            make.top.equalTo(imageV.snp.bottom).offset(Adapt(6))
            make.centerX.equalTo(imageV.snp.centerX)
        })
        
        self.titleLab.textAlignment = .center
    }
}
