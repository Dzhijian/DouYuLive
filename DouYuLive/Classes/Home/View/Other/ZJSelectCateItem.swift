//
//  ZJSelectCateItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/9.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJSelectCateItem: ZJBaseCollectionCell {
    
    var titleLab : UILabel = {
        let label = UILabel()
        label.textColor = kGrayTextColor
        label.font  = FontSize(12)
        label.textAlignment = .center
        label.text = "测试"
        return label
    }()
    
    override func zj_setUpAllView() {
        self.contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
}
