//
//  ZJProfileHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/22.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

@objc protocol ZJProfileHeadViewDelegate {
    @objc optional func zj_loginBtnAction(sender : UIButton)
}

class ZJProfileHeadView: ZJBaseView {
    
    weak var deleagte : ZJProfileHeadViewDelegate?
    private lazy var titleLab : UILabel = UILabel()
    private lazy var loginBtn : UIButton = UIButton()
    private lazy var registerBtn : UIButton = UIButton()
    private lazy var descLab : UILabel = UILabel()
    private lazy var bgImgV : UIImageView = UIImageView()
    
    private lazy var childView : UIView = UIView()
    
    private lazy var titles : [String] = ["消息","斗鱼贵族","鱼翅充值"]
    
    private lazy var icons : [String] = ["icon_message","icon_noble","icon_recharge"]
    override func zj_initWithAllView() {
        setUpAllView()
    }
}


// 配置 UI 视图
extension ZJProfileHeadView {
    
    private func setUpAllView() {
        self.titleLab = UILabel.zj_createLabel(text: "欢迎来到斗鱼", textColor:  kMainTextColor, font: BoldFontSize(20), supView: self, closure: { (make) in
            make.top.equalTo(Adapt(30))
            make.left.equalTo(Adapt(25))
        })
        
        self.loginBtn = UIButton.zj_createButton(title: "登录", titleStatu: . normal, imageName: nil, imageStatu: nil, supView: self, closure: { (make) in
            make.left.equalTo(Adapt(25))
            make.top.equalTo(self.titleLab.snp.bottom).offset(Adapt(15))
            make.width.equalTo(Adapt(80))
            make.height.equalTo(34)
        })
        self.loginBtn.titleLabel?.font = FontSize(14)
        self.loginBtn.setTitleColor(kWhite, for: .normal)
        self.loginBtn.layer.cornerRadius = 3
        self.loginBtn.backgroundColor = kMainOrangeColor
        zj_setUpGradientLayer(view: self.loginBtn, frame: CGRect(x: 0, y: 0, width: Adapt(80), height: Adapt(30)), color: kGradientColors,corneradiu: 4)
    
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        
        self.registerBtn = UIButton.zj_createButton(title: "注册", titleStatu: . normal, imageName: nil, imageStatu: nil, supView: self, closure: { (make) in
            make.left.equalTo(self.loginBtn.snp.right).offset(Adapt(12))
            make.top.equalTo(self.titleLab.snp.bottom).offset(Adapt(15))
            make.width.equalTo(Adapt(80))
            make.height.equalTo(34)
        })
        
        self.registerBtn.titleLabel?.font = FontSize(14)
        self.registerBtn.setTitleColor(kMainOrangeColor, for: .normal)
        self.registerBtn.layer.cornerRadius = 3
        self.registerBtn.layer.borderColor = kMainOrangeColor.cgColor
        self.registerBtn.layer.borderWidth = 1
        
        self.descLab = UILabel.zj_createLabel(text: "重返石器时代,回合制始", textColor:  kGrayTextColor, font: FontSize(12), supView: self, closure: { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(Adapt(30))
            make.left.equalTo(Adapt(25))
        })
        
        self.bgImgV = UIImageView.zj_createImageView(imageName: "big_user_guide_robot", supView: self, closure: { (make) in
            make.left.equalTo(self.registerBtn.snp.right).offset(Adapt(30))
            make.top.equalTo(self.titleLab.snp.bottom).offset(Adapt(10))
            make.width.equalTo(Adapt(110))
            make.height.equalTo(Adapt(135))
        })
        
        self.childView = UIView.zj_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.top.equalTo(self.descLab.snp.bottom).offset(Adapt(15))
            make.left.right.equalTo(0)
            make.height.equalTo(Adapt(90))
        })
        
        _ = UIView.zj_createView(bgClor: klineColor, supView: self.childView, closure: { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(0.6)
        })
        
        
        let itemW = kScreenW/3
        for (index,title) in titles.enumerated() {
            let itemx = itemW * CGFloat(index)
            setUpOneItem(supView:childView ,title: title, iconName: icons[index] , itemX:itemx)
        
        }
        
    }
    
    @objc func loginBtnClick(sender: UIButton) {
        deleagte?.zj_loginBtnAction!(sender: sender)
    }
    
    func setUpOneItem(supView : UIView, title: String, iconName: String, itemX: CGFloat) {
        
        let view  = UIView(frame: CGRect(x: itemX, y: 1, width: kScreenW/3, height: Adapt(80)))

        view.backgroundColor = kWhite
        supView.addSubview(view)
        let icon  = UIImageView()
        icon.image = UIImage(named: iconName)
        view.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(Adapt(15))
            make.width.equalTo(Adapt(30))
            make.height.equalTo(Adapt(30))
        }
        
        let titleLab = UILabel()
        titleLab.text = title
        titleLab.font = FontSize(12)
        titleLab.textColor = kGrayTextColor
        view.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(icon.snp.centerX)
            make.top.equalTo(icon.snp.bottom).offset(Adapt(10))
        }
    
    }
}


