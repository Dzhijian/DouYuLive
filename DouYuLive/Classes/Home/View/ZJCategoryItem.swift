//
//  ZJCategoryItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCategoryItem: ZJBaseCollectionCell {
    
    private lazy var icon : UIImageView = {
        let icon = UIImageView()
        
        return icon
    }()
    
    private lazy var titleLab :UILabel = {
        let lab = UILabel()
        lab.textColor = kMainTextColor
        lab.font = FontSize(15)
        lab.backgroundColor = kWhite
        lab.textAlignment = .center
        return lab
    }()
    
    override func zj_setUpAllView() {
        setUpAllView()
    }
    
}



extension ZJCategoryItem {
    
    private func setUpAllView(){
        addSubview(icon)
        addSubview(titleLab)
        
        icon.snp.makeConstraints { (make) in
            make.top.left.equalTo(10);
            make.right.equalTo(-10)
            make.height.equalTo(60)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-15)
            make.left.right.equalTo(0)
        }
        
        icon.backgroundColor = kOrange
        titleLab.text = "英雄联盟"
    }
}
