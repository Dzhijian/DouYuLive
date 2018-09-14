//
//  ZJLoginView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/14.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJLoginView: ZJBaseView {
    
    // 地区
    private lazy var areaView : UIView = UIView()
    private lazy var areaLab : UILabel = UILabel()
    private lazy var areaImgV : UIImageView = UIImageView()
    private lazy var areaNameLab : UILabel = UILabel()
    
    // 手机
    private lazy var mobileView : UIView = UIView()
    private lazy var mobileLab : UILabel = UILabel()
    private lazy var mobileTF : UITextField = UITextField()
    
    // 密码
    private lazy var pwdView : UIView = UIView()
    private lazy var pwdImgV : UIImageView = UIImageView()
    private lazy var pwdTF : UITextField = UITextField()
    
    // 验证码
    private lazy var codeView : UIView = UIView()
    private lazy var codeImgV : UIImageView = UIImageView()
    private lazy var codeTF : UITextField = UITextField()
    private lazy var codeBtn : UIButton = UIButton()
    
    // 登录或注册按钮
    private lazy var actionBtn : UIButton = UIButton()
    // 忘记密码按钮
    private lazy var forgetBtn : UIButton = UIButton()
    // 验证码登录按钮
    private lazy var codeLoginBtn : UIButton = UIButton()
    // 快速登录按钮
    private lazy var quickLoginBtn : UIButton = UIButton()
    // 马上登录按钮
    private lazy var nowLoginBtn : UIButton = UIButton()
    
    
    override func zj_initWithAllView() {
        setUpAllView()
    }

}


// 配置 UI 视图
extension ZJLoginView {
    
    private func setUpAllView() {
        backgroundColor = kBGGrayColor
        
        areaView = UIView.zj_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.left.equalTo(Adapt(20))
            make.right.equalTo(Adapt(-20))
            make.top.equalTo(Adapt(20))
            make.height.equalTo(Adapt(50))
        })
        
        
        areaLab = UILabel.zj_createLabel(text: "国家与地区", textColor:  kGrayTextColor, font: FontSize(14), supView: areaView, closure: { (make) in
            make.centerY.equalTo(areaView.snp.centerY)
            make.left.equalTo(areaView.snp.left).offset(Adapt(10))
            make.width.equalTo(Adapt(110))
        })
        
        areaImgV = UIImageView.zj_createImageView(imageName: "right_arrow_gray", supView: areaView, closure: { (make) in
            make.centerY.equalTo(areaView.snp.centerY)
            make.right.equalTo(areaView.snp.right).offset(-Adapt(5))
            make.width.equalTo(Adapt(13))
            make.height.equalTo(Adapt(20))
        })
        
        areaImgV.contentMode = .scaleAspectFill
    }
    
    
}
