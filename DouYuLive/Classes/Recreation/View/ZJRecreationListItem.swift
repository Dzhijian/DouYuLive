//
//  ZJRecreationListItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/10.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemH = (kScreenW - 5) / 2

class ZJRecreationListItem: ZJBaseCollectionCell {
    
    private lazy var imgV = UIImageView()
    private lazy var markImgV = UIImageView()
    private lazy var hotLab = UILabel()
    private lazy var nameLab = UILabel()
    private lazy var addressLab = UILabel()
    private lazy var descLab = UILabel()
    
    var faceHotModel : ZJFaceScoreHotList? {
        
        didSet{
            //不能使用强制解包策略
            if let iconURL = URL(string: faceHotModel?.room_src ?? "") {
                imgV.kf.setImage(with: iconURL)
            } else {
                imgV.image = UIImage(named: "video_default_cover")
            }
            
            nameLab.text = faceHotModel?.nickname
            addressLab.text = faceHotModel?.anchor_city
            descLab.text = faceHotModel?.room_name
            hotLab.text = faceHotModel?.online_num?.description
        }
    }
    
    
    override func zj_setUpAllView() {
        setUpAllView()
    }
}


// 配置 UI 视图
extension ZJRecreationListItem {
    
    private func setUpAllView() {
        self.imgV = UIImageView.zj_createImageView(imageName: "", supView: self.contentView, closure: { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kItemH)
        })
        self.imgV.contentMode = .scaleToFill
        
        self.imgV.backgroundColor = kOrange
        
        self.markImgV = UIImageView.zj_createImageView(imageName: "", supView: self.imgV, closure: { (make) in
            make.top.equalTo(Adapt(10))
            make.left.equalTo(Adapt(10))
            make.width.equalTo(Adapt(80))
            make.height.equalTo(Adapt(20))
        })
        
//        self.markImgV.backgroundColor = kGreen
        
        self.hotLab = UILabel.zj_createLabel(text: "1.5W", textColor:  kWhite, font: FontSize(10), textAlignment: .left, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.markImgV.snp.centerY)
            make.right.equalTo(Adapt(-10))
        })
        
        self.nameLab = UILabel.zj_createLabel(text: "哈哈哈", textColor:  kMainTextColor, font: FontSize(14), textAlignment: .left, supView: self.contentView, closure: { (make) in
            make.left.equalTo(Adapt(10))
            make.top.equalTo(self.imgV.snp.bottom).offset(Adapt(10))
        })
        
        self.addressLab = UILabel.zj_createLabel(text: "深圳市", textColor:  kGrayTextColor, font: FontSize(13), textAlignment: .right, supView: self.contentView, closure: { (make) in
            make.right.equalTo(Adapt(-10))
            make.centerY.equalTo(self.nameLab.snp.centerY)
        })
       
        self.descLab = UILabel.zj_createLabel(text: "小心老王", textColor:  kGrayTextColor, font: FontSize(12), textAlignment: .left, supView: self.contentView, closure: { (make) in
            make.left.equalTo(Adapt(10))
            make.top.equalTo(self.nameLab.snp.bottom).offset(Adapt(5))
        })
    }
}
