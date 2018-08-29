//
//  ZJCategoryItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCategoryItem: ZJBaseCollectionCell {
    
    
    var model : ZJRecomCateList? {
        didSet{
            titleLab.text = model?.cate2_name
            //不能使用强制解包策略
            if let iconURL = URL(string: model?.square_icon_url ?? "") {
                icon.kf.setImage(with: iconURL)
            } else {
                icon.image = UIImage(named: "home_column_more")//home_more_btn
            }
        }
    }
    
    
    private lazy var icon : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var titleLab :UILabel = {
        let lab = UILabel()
        lab.textColor = kGrayTextColor
        lab.font = FontSize(12)
        lab.backgroundColor = kWhite
        lab.textAlignment = .center
        return lab
    }()
    
    override func zj_initWithView() {
        setUpAllView()
    }
    
}



extension ZJCategoryItem {
    
    private func setUpAllView(){
        addSubview(icon)
        addSubview(titleLab)
        
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(60)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-10)
            make.left.equalTo(3)
            make.right.equalTo(-3)
        }
        
    }
}
