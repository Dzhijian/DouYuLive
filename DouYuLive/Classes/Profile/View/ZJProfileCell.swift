//
//  ZJProfileCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/22.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJProfileCell: ZJBaseTableCell {

    lazy var icon : UIImageView = UIImageView()
    lazy var titleLab : UILabel = UILabel()
    private lazy var arrowIcon : UIImageView = UIImageView()
    private lazy var detailLab : UILabel = UILabel()
    
    override func zj_setUpAllView() {
        setUpAllView()
    }
    
}


// 配置 UI 视图
extension ZJProfileCell {
    
    private func setUpAllView() {
        self.icon = UIImageView.zj_createImageView(imageName: "icon_accompany", contentMode: nil, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(15))
            make.width.height.equalTo(Adapt(22))
        })
        
        self.titleLab = UILabel.zj_createLabel(text: "标题", textColor:  kMainTextColor, font: FontSize(14), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.icon.snp.right).offset(Adapt(15))
            
        })
        
        self.arrowIcon = UIImageView.zj_createImageView(imageName: "im_arrow_right1", contentMode: nil, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(Adapt(-15))
            make.width.equalTo(Adapt(10))
            make.height.equalTo(Adapt(14))
        })
        
        self.detailLab = UILabel.zj_createLabel(text: "副标题", textColor:  kGrayTextColor, font: FontSize(12), supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.arrowIcon.snp.left).offset(Adapt(-15))
            
        })

    }
}
