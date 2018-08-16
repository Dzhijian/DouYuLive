//
//  ZJLiveListItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/3.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

let ItemH : CGFloat = (kScreenW - 10) / 2 * 9 / 16

class ZJLiveListItem: ZJBaseCollectionCell {
    var imageV = UIImageView()
    var nameLab = UILabel()
    var titleLab = UILabel()
    var descLab = UILabel()
    var hotLab = UILabel()
    

    override func zj_setUpAllView() {
        setUpAllView()
    }
    
    var interesModel : ZJFollowInterseList? {
        didSet{
            titleLab.text = interesModel?.roomName
            nameLab.text =  interesModel?.nickname
            
            var numStr : String = ""
            if (interesModel?.followNum)! > 9999 {
                let integer =  (interesModel?.followNum)! / 10000
                let remainder : Int =  Int((interesModel?.followNum)! % 10000)
                let numString = "\(integer).\(remainder)"
                let numFloat = Float(numString)
                numStr = "\(String(format: "%.2f", numFloat!))W"
            }else{
                numStr = (interesModel?.followNum?.description)!
            }
            
            hotLab.text = numStr
            descLab.text = interesModel?.cate2Name
            
            //不能使用强制解包策略
            if let iconURL = URL(string: interesModel?.roomSrc ?? "") {
                imageV.kf.setImage(with: iconURL)
            } else {
                imageV.image = UIImage(named: "video_default_cover")
            }
        }
    }
    

    var liveModel : ZJLiveItemModel? {
        didSet{
            titleLab.text = liveModel?.room_name
            nameLab.text =  liveModel?.nickname
            
            var numStr : String = ""
            if (liveModel?.online_num)! > 9999 {
                let integer =  (liveModel?.online_num)! / 10000
                let remainder : Int =  Int((liveModel?.online_num)! % 10000)
                let numString = "\(integer).\(remainder)"
                let numFloat = Float(numString)
                numStr = "\(String(format: "%.2f", numFloat!))W"
            }else{
                numStr = (liveModel?.online_num?.description)!
            }
            
            hotLab.text = numStr
            descLab.text = liveModel?.cate2_name
            
            //不能使用强制解包策略
            if let iconURL = URL(string: liveModel?.room_src ?? "") {
                imageV.kf.setImage(with: iconURL)
            } else {
                imageV.image = UIImage(named: "video_default_cover")
            }
        }
    }
}




// MARK: - 配置 UI
extension ZJLiveListItem {
    
    private func setUpAllView (){
    
        self.imageV = UIImageView.zj_createImageView(imageName: "liveImage", supView: self, closure: { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(ItemH)
        })
        
        self.nameLab = UILabel.zj_createLabel(text: "coder", textColor: kWhite, font: FontSize(12), supView: self.imageV, closure: { (make) in
            make.bottom.equalTo(self.imageV.snp.bottom).offset(-5)
            make.left.equalTo(self.imageV.snp.left).offset(10)
            make.right.equalTo(self.imageV.snp.right).offset(-5)
        })
        
        self.titleLab = UILabel.zj_createLabel(text: "房间待着太无聊.哈哈哈哈哈哈哈哈哈哈", textColor: kBlack, font: FontSize(14), supView: self.contentView, closure: { (make) in
            make.top.equalTo(self.imageV.snp.bottom).offset(10)
            make.left.equalTo(self.contentView.snp.left).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
        })
        
        self.descLab = UILabel.zj_createLabel(text: "QQ 飞车端游 >", textColor: UIColor.lightGray, font: FontSize(12), supView: self.contentView, closure: { (make) in
            make.top.equalTo(self.titleLab.snp.bottom).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(5)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
        })
        
        self.hotLab = UILabel.zj_createLabel(text: "9.0W", textColor: kWhite, font: FontSize(10), supView: self.imageV, closure: { (make) in
            make.bottom.equalTo(self.imageV.snp.bottom).offset(-5)
            make.left.equalTo(self.imageV.snp.left).offset(10)
            make.right.equalTo(self.imageV.snp.right).offset(-5)
        })
        self.hotLab.textAlignment = .right
    }
}
