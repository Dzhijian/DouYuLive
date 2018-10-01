//
//  ZJFollowLiveHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJFollowLiveHeadView : UIView {
    
    // 闭包 类似oc中的block
    var loginBtnCallBack:(() -> ())?
    
    private lazy var iconArr : [UIImageView] = {
        let iconArr = [UIImageView]()
        return iconArr
    }()
    
    private lazy var loginBtn : UIButton = UIButton()
    private lazy var descLab : UILabel = UILabel()
    private lazy var bgImgV : UIImageView = UIImageView()
    // 排行榜
    private lazy var anchorRankView : UIView = {
        let rankView = UIView()
        return rankView
    }()
    
    private lazy var arrowIcon : UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "btn_more")
        return arrow
    }()
    private lazy var rankLab : UILabel = {
        let lab = UILabel()
        lab.text = "超级主播榜"
        lab.textColor = colorWithRGBA(180, 180, 180, 1)
        lab.font = FontSize(17)
        return lab
    }()
    var imgUrlArr : [String] = [String]()
    
    var rankList : [ZJFollowRankList]?{
        didSet{
            
            for (_,item) in (rankList?.enumerated())! {
                imgUrlArr.append(item.avatar!)
            }
            
            setUpRankIconView(imgUrl: imgUrlArr)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 配置 UI 视图
extension ZJFollowLiveHeadView {
    
    private func setUpAllView() {
        self.loginBtn = UIButton.zj_createButton(title: "登 录", titleStatu: . normal, imageName: "", imageStatu: nil, supView: self, closure: { (make) in
            make.top.equalTo(Adapt(30))
            make.left.equalTo(Adapt(20))
            make.width.equalTo(Adapt(130))
            make.height.equalTo(Adapt(30))
        })
        loginBtn.setTitleColor(kWhite, for: .normal)
        loginBtn.titleLabel?.font = BoldFontSize(14)
        loginBtn.layer.cornerRadius = 3
        loginBtn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)

        zj_setUpGradientLayer(view: self.loginBtn, frame: CGRect(x: 0, y: 0, width: Adapt(120), height: Adapt(30)), color: kGradientColors, corneradiu: 3)
        
        self.descLab = UILabel.zj_createLabel(text: "登录可关注你最喜欢的主播", textColor: colorWithRGBA(180, 180, 180, 1), font: FontSize(10), supView: self, closure: { (make) in
            make.centerX.equalTo(self.loginBtn.snp.centerX)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(Adapt(10))
        })
        
        self.bgImgV = UIImageView.zj_createImageView(imageName: "dyunion_logo_1", supView: self, closure: { (make) in
            make.right.equalTo(Adapt(-40))
            make.top.equalTo(Adapt(10))
            make.width.height.equalTo(Adapt(120))
        })
        
        anchorRankView = UIView.zj_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.top.equalTo(self.descLab.snp.bottom).offset(Adapt(40))
            make.left.equalTo(Adapt(10))
            make.right.equalTo(Adapt(-10))
            make.height.equalTo(Adapt(70))
        })
        
        anchorRankView.layer.masksToBounds = false
        anchorRankView.layer.cornerRadius = 3
        anchorRankView.layer.shadowColor = colorWithRGBA(99, 99, 99, 1).cgColor
        anchorRankView.layer.shadowOpacity = 0.2
        anchorRankView.layer.shadowRadius = 5
        anchorRankView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        anchorRankView.addSubview(rankLab)
        rankLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(anchorRankView.snp.centerY)
            make.left.equalTo(Adapt(15))
        }
        
        anchorRankView.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(anchorRankView.snp.centerY)
            make.width.equalTo(13)
            make.height.equalTo(13)
            make.right.equalTo(Adapt(-15))
        }
    }
    
    func setUpRankIconView(imgUrl : [String]) {
        for ( index ,urlStr) in imgUrl.enumerated() {
            let icon = UIImageView()
            icon.layer.cornerRadius = Adapt(20)
            icon.layer.borderColor = kWhite.cgColor
            icon.layer.borderWidth = 1.5
            icon.layer.masksToBounds = true
            icon.contentMode = .scaleAspectFill
            icon.tag = index
            icon.image = UIImage(named: "liveImage")
            icon.zj_setImage(urlStr: urlStr, placeholder: UIImage(named: "icon_logo"))
            anchorRankView.addSubview(icon)
            iconArr.append(icon)
        }
        
        self.layoutSubviews()
    }
    
    @objc func loginBtnAction(){
        if loginBtnCallBack != nil{
            loginBtnCallBack!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconWH : CGFloat = Adapt(40)
        let iconY : CGFloat = (anchorRankView.frame.size.height - iconWH) / 2

        for (index,icon) in iconArr.enumerated() {
            let iconX = kScreenW - Adapt(20) - CGFloat(index+1) * (iconWH - (Adapt(12))) - Adapt(45)
            
            icon.frame = CGRect(x: iconX, y: iconY, width: iconWH, height: iconWH)
        }
    }
}
