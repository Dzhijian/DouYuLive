//
//  ZJVideoListCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/9.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

private let kVideoH : CGFloat = kScreenW * 9 / 16

class ZJVideoListCell: ZJBaseTableCell {
    private lazy var imageV = UIImageView()
    private lazy var nameLab = UILabel()
    private lazy var likeBtn = UIButton()
    private lazy var avatar : UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = Adapt(15)
        avatar.layer.masksToBounds = true
        avatar.image = UIImage(named: "micLink_seatAreaPlaceholder")
        return avatar
    }()
    var videoModel : ZJFollowVideoList?{
        didSet{
            if let imgUrl = URL(string:videoModel?.video_cover ?? "")  {
                self.imageV.kf.setImage(with: imgUrl)
            }else{
                self.imageV.image = UIImage(named: "anchorImage_placeHolder")
            }
            
            if let avatarUrl = URL(string:videoModel?.owner_avatar ?? "")  {
                self.avatar.kf.setImage(with: avatarUrl)
            }else{
                self.avatar.image = UIImage(named: "anchorImage_placeHolder")
            }
            
            nameLab.text = videoModel?.nickname
            likeBtn.setTitle(videoModel?.video_collect_num?.description, for: .normal)
        }
    }
    
    override func zj_setUpAllView() {
        setUpAllView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class func cellHeight() -> CGFloat {
        return kVideoH + Adapt(40)
    }
    

}

// 配置 UI 视图
extension ZJVideoListCell {
    
    private func setUpAllView() {
        
        self.imageV = UIImageView.zj_createImageView(imageName: "", supView: self.contentView, closure: { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(kVideoH)
        })
        
        self.imageV.backgroundColor = kOrange
        self.nameLab = UILabel.zj_createLabel(text: "CoderDeng", textColor: kGrayTextColor, font: FontSize(12), supView: self.contentView, closure: { (make) in
            make.left.equalTo(Adapt(15))
            make.top.equalTo(self.imageV.snp.bottom).offset(Adapt(10))
        })
        
        self.likeBtn = UIButton.zj_createButton(title: "100", titleStatu: .normal, imageName: "", imageStatu: .normal, supView: self.contentView, closure: { (make) in
            make.right.equalTo(Adapt(-15))
            make.centerY.equalTo(self.nameLab.snp.centerY)
            make.height.equalTo(Adapt(30))
        })
        self.likeBtn.titleLabel?.font = FontSize(12)
        self.likeBtn.setTitleColor(kGrayTextColor, for: .normal)
        
        self.imageV.addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.left.equalTo(Adapt(15))
            make.width.height.equalTo(Adapt(30))
            make.bottom.equalTo(imageV.snp.bottom).offset(Adapt(5))
        }
    }
    

}

