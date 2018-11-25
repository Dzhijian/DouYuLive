//
//  ZJGameItemCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJGameItemCell: ZJBaseTableCell {
    private lazy var titleLab : UILabel = UILabel()
    private lazy var descLab : UILabel = UILabel()
    private lazy var leftImg : UIImageView = UIImageView()
    private lazy var leftName : UILabel = UILabel()
    private lazy var leftScore : UILabel = UILabel()
    private lazy var rightImg : UIImageView = UIImageView()
    private lazy var rightName : UILabel = UILabel()
    private lazy var rightScore : UILabel = UILabel()
    private lazy var scoreLab : UILabel = UILabel()
    private lazy var statuBtn : UIButton = UIButton()
    lazy var botLine : UIView = UIView()
    
    override func zj_initWithView() {
        setUpAllView()
    
    }
    
    var model : ZJDiscoverGameList?{
        didSet{
            if model == nil {
                return
            }
            let time = timeStampToString(timeStamp: model?.start_time?.description ?? "0", format: "HH:mm MM月dd日")
            titleLab.text = timeStampToString(timeStamp: model?.start_time?.description ?? "0", format: "yyyy年MM月dd日")
//            descLab.text =  (model?.game_name)!  + " / \(time)" + "  第\(model?.round!.description ?? "0")场"
            
            leftImg.zj_setImage(urlStr: model?.player1_icon ?? "")
            rightImg.zj_setImage(urlStr: model?.player2_icon ?? "")
            leftName.text = model?.player1_name
            rightName.text = model?.player2_name
            leftScore.text = model?.player1_score?.description
            rightScore.text = model?.player2_score?.description
        }
    }
    

}

// MARK: -
extension ZJGameItemCell {
    
    
   
}


// 配置 UI 视图
extension ZJGameItemCell {
    
    private func setUpAllView() {
        
        self.titleLab = UILabel.zj_createLabel(text: "标题哦", textColor:  kMainTextColor, font: FontSize(16), textAlignment: .center, supView: self.contentView, closure: { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(Adapt(25))
        })
        
        self.descLab = UILabel.zj_createLabel(text: "副标题哦", textColor:  kLowGrayColor, font: FontSize(12), textAlignment: .center, supView: self.contentView, closure: { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        })
        
        self.scoreLab = UILabel.zj_createLabel(text: ":", textColor:  kMainTextColor, font: BoldFontSize(24), textAlignment: .center, supView: self.contentView, closure: { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(descLab.snp.bottom).offset(30)
            make.width.equalTo(Adapt(25))
        })
        
        self.leftImg = UIImageView.zj_createImageView(imageName: "liveImage", supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.scoreLab.snp.centerY)
            make.left.equalTo(Adapt(30))
            make.width.height.equalTo(Adapt(45))
        })
        self.leftName = UILabel.zj_createLabel(text: "Left", textColor:  kMainTextColor, font: BoldFontSize(15), textAlignment: .left, supView: self.contentView, closure: { (make) in
            make.left.equalTo(leftImg.snp.right).offset(Adapt(10))
            make.centerY.equalTo(leftImg.snp.centerY)
        })
        
        self.leftScore = UILabel.zj_createLabel(text: "0", textColor:  kMainTextColor, font: BoldFontSize(30), textAlignment: .center, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.scoreLab.snp.centerY)
            make.right.equalTo(self.scoreLab.snp.left)
        })
        
        self.rightImg = UIImageView.zj_createImageView(imageName: "liveImage", supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.scoreLab.snp.centerY)
            make.right.equalTo(Adapt(-30))
            make.width.height.equalTo(Adapt(50))
        })
        self.rightName = UILabel.zj_createLabel(text: "right", textColor:  kMainTextColor, font: BoldFontSize(15), textAlignment: .right, supView: self.contentView, closure: { (make) in
            make.right.equalTo(rightImg.snp.left).offset(Adapt(-10))
            make.centerY.equalTo(rightImg.snp.centerY)
        })
        
        self.rightScore = UILabel.zj_createLabel(text: "0", textColor:  kMainTextColor, font: BoldFontSize(30), textAlignment: .center, supView: self.contentView, closure: { (make) in
            make.centerY.equalTo(self.scoreLab.snp.centerY)
            make.left.equalTo(self.scoreLab.snp.right)
        })
        
        self.statuBtn = UIButton.zj_createButton(title: "预约", titleStatu: . normal, imageName: nil, imageStatu: nil, supView: self.contentView, closure: { (make) in
            make.bottom.equalTo(Adapt(-25))
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(Adapt(70))
            make.height.equalTo(Adapt(25))
        })
        self.statuBtn.titleLabel?.font = FontSize(13)
        self.statuBtn.setTitleColor(kOrange, for: .normal)
        self.statuBtn.backgroundColor = colorWithRGBA(251, 228, 213, 1.0)
        self.statuBtn.layer.cornerRadius = 3
        
        self.botLine = UIView.zj_createView(bgClor: klineColor, supView: self.contentView, closure: { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(Adapt(10))
            make.right.equalTo(Adapt(-10))
            make.height.equalTo(0.6)
        })
        
    }
}
