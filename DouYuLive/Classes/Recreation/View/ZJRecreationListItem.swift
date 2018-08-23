//
//  ZJRecreationListItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/10.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kItemH = (kScreenW - 5) / 2 - Adapt(30)

class ZJRecreationListItem: ZJBaseCollectionCell {
    
    private lazy var imgV :UIImageView = UIImageView()
    private lazy var markImgV : UIImageView = UIImageView()
    private lazy var hotLab :UILabel = UILabel()
    private lazy var nameLab : UILabel = UILabel()
    private lazy var addressLab : UILabel = UILabel()
    private lazy var descLab : UILabel = UILabel()
    
    private lazy var hotBGView : UIView = {
        let view = UIView()
        view.backgroundColor = colorWithRGBA(55, 55, 55, 0.9)
        view.layer.borderColor = colorWithRGBA(220, 220, 220, 1.0).cgColor
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        return view
    }()
    private lazy var hotImgV : UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "ico_rec_hot")
        return imgV
    }()
    var faceHotModel : ZJLiveItemModel? {
        
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
            
            var numStr : String = ""
            
            if (faceHotModel?.online_num)! > 9999 {
                let integer =  (faceHotModel?.online_num)! / 10000
                let remainder : Int =  Int((faceHotModel?.online_num)! % 10000)
                let numString = "\(integer).\(remainder)"
                let numFloat = Float(numString)
                numStr = "\(String(format: "%.2f", numFloat!))W"
            }else{
                numStr = (faceHotModel?.online_num?.description)!
            }
            
            hotLab.text = numStr //faceHotModel?.online_num?.description
        }
    }
    
    
    override func zj_initWithView() {
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
        
        self.imgV.backgroundColor = klineColor
        
        self.markImgV = UIImageView.zj_createImageView(imageName: "", supView: self.imgV, closure: { (make) in
            make.top.equalTo(Adapt(10))
            make.left.equalTo(Adapt(10))
            make.width.equalTo(Adapt(80))
            make.height.equalTo(Adapt(20))
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
        
        self.imgV.addSubview(self.hotBGView)
        self.hotBGView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.markImgV.snp.centerY)
            make.right.equalTo(Adapt(-5))
            make.width.equalTo(Adapt(55))
            make.height.equalTo(Adapt(20))
        }
        
        self.hotBGView.addSubview(hotImgV)
        hotImgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.hotBGView.snp.centerY)
            make.left.equalTo(2)
            make.width.equalTo(Adapt(15))
        }
        hotImgV.contentMode = .scaleAspectFit
        self.hotLab = UILabel.zj_createLabel(text: "1.5W", textColor:  kWhite, font: FontSize(9), textAlignment: .center, supView: self.hotBGView, closure: { (make) in
            make.centerY.equalTo(self.markImgV.snp.centerY)
            make.right.equalTo(Adapt(-2))
            make.left.equalTo(self.hotImgV.snp.right).offset(2)
        })
        
    }
}
