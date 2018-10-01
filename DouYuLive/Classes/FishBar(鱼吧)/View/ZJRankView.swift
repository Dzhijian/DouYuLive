//
//  ZJRankView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/21.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJRankView: ZJBaseView {

    private lazy var icon : UIImageView = UIImageView()
    private lazy var titleLab : UILabel = UILabel()
    private lazy var arrowIcon : UIImageView = UIImageView()
    
    private lazy var avatarArr : [UIImageView] = {
        let avatarArr = [UIImageView]()
        return avatarArr
    }()
    override func zj_initWithAllView() {
        
        self.icon = UIImageView.zj_createImageView(imageName: "homeNewItem_rankingList", supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(10))
            make.width.equalTo(Adapt(25))
            make.height.equalTo(Adapt(25))
        })
        
        self.titleLab = UILabel.zj_createLabel(text: "鱼吧排行", textColor: kMainTextColor, font: FontSize(18), supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(Adapt(3))
        })
        
        self.arrowIcon = UIImageView.zj_createImageView(imageName: "link_detail_icon", supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(Adapt(-10))
            make.width.equalTo(Adapt(15))
            make.height.equalTo(15)
        })
        
        setUpRankIconView(imgUrl: ["","",""])
    }

    // 配置排行版头像
    func setUpRankIconView(imgUrl : [String]) {
        for ( index ,urlStr) in imgUrl.enumerated() {
            let icon = UIImageView()
            icon.layer.cornerRadius = Adapt(20)
            icon.layer.borderColor = kWhite.cgColor
            icon.layer.borderWidth = 1.5
            icon.layer.masksToBounds = true
            icon.contentMode = .scaleAspectFill
            icon.tag = index
            icon.zj_setImage(urlStr: urlStr, placeholder: UIImage(named: "icon_logo"))
            self.addSubview(icon)
            avatarArr.append(icon)
        }
        
        self.layoutSubviews()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconWH : CGFloat = Adapt(40)
        let iconY : CGFloat = (self.frame.size.height - iconWH) / 2
        
        for (index,icon) in avatarArr.enumerated() {
            let iconX = self.frame.size.width  - CGFloat(index+1) * (iconWH - (Adapt(12))) - Adapt(45)
            
            icon.frame = CGRect(x: iconX, y: iconY, width: iconWH, height: iconWH)
        }
    }
}
