//
//  ZJRankCellItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJRankCellItem: ZJBaseCollectionCell {
    private lazy var bgView : UIView = UIView()
    private lazy var avatar : UIImageView = UIImageView()
    private lazy var liveImgV : UIImageView = UIImageView()
    private lazy var rankImgV : UIImageView = UIImageView()
    private lazy var nameLab : UILabel = UILabel()
    private lazy var descLab : UILabel = UILabel()
    private lazy var likeBtn : UIButton = UIButton()
    
    var model : ZJAnchorRankList? {
        didSet{

            self.avatar.zj_setImage(urlStr: model?.avatar ?? "", placeholder: nil)
            self.nameLab.text = model?.nickname
            self.descLab.text = model?.catagory
            
//            self.liveImgV.isHidden = Int((model?.is_live)!)! == 0 ? true : false
        }
    }
    
    override func zj_initWithView() {
        setUpAllView()
    }
}

// 配置 UI 视图
extension ZJRankCellItem {
    
    private func setUpAllView() {
        self.bgView = UIView.zj_createView(bgClor: colorWithRGBA(240, 240, 240, 1.0), supView: self.contentView, closure: { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-Adapt(10))
            make.top.equalTo(Adapt(20))
        })
        
        self.avatar = UIImageView.zj_createImageView(imageName: "liveImage", supView: self.bgView, closure: { (make) in
            make.top.equalTo(self.bgView.snp.top).offset(-Adapt(20))
            make.centerX.equalTo(self.bgView.snp.centerX)
            make.width.height.equalTo(Adapt(60))
        })
        
        self.avatar.layer.cornerRadius = Adapt(30)
        self.avatar.layer.masksToBounds = true
//
        self.liveImgV = UIImageView.zj_createImageView(imageName: "video_slay_live", supView: self.bgView, closure: { (make) in
            make.top.equalTo(self.avatar.snp.top)
            make.left.equalTo(self.avatar.snp.right).offset(Adapt(-18))
            make.width.equalTo(Adapt(35))
            make.height.equalTo(Adapt(14))
        })
        
        self.rankImgV = UIImageView.zj_createImageView(imageName: "home_live_vertical_icon", supView: self.bgView, closure: { (make) in
            make.centerX.equalTo(self.bgView.snp.centerX)
            make.top.equalTo(self.avatar.snp.bottom).offset(Adapt(-6))
            make.width.equalTo(Adapt(30))
            make.height.equalTo(Adapt(12))
        })
        
        self.nameLab = UILabel.zj_createLabel(text: "昵称", textColor:  kMainTextColor, font: FontSize(12), supView: self.bgView, closure: { (make) in
            make.centerX.equalTo(self.bgView.snp.centerX)
            make.top.equalTo(self.avatar.snp.bottom).offset(Adapt(12))
            make.height.equalTo(Adapt(14))
        })
        
        self.descLab = UILabel.zj_createLabel(text: "飞车", textColor:   colorWithRGBA(180, 180, 180, 1.0), font: FontSize(10), supView: self.bgView, closure: { (make) in
            make.centerX.equalTo(self.bgView.snp.centerX)
            make.top.equalTo(self.nameLab.snp.bottom).offset(Adapt(5))
            make.height.equalTo(Adapt(12))
        })
        
        self.likeBtn = UIButton.zj_createButton(title: "关注", titleStatu: . normal, imageName: "", imageStatu: nil, supView: self.bgView, closure: { (make) in
            make.centerX.equalTo(self.bgView.snp.centerX)
            make.bottom.equalTo(-Adapt(10))
            make.height.equalTo(Adapt(18))
            make.width.equalTo(Adapt(40))
        })
        self.likeBtn.titleLabel?.font = FontSize(11)
        self.likeBtn.setTitleColor(kWhite, for: .normal)
        self.likeBtn.backgroundColor = kOrange
        self.likeBtn.layer.cornerRadius = 3
    }
}
