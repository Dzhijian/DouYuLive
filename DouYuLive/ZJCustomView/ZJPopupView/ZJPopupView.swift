//
//  ZJPopupView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/9/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

enum ZJPopupAnimationStyle {
    case ZJPopTransition    // 移动
    case ZJRotation         // 旋转
    case ZJPopupSacle       // 缩放动画
    case ZJAlpha            // 渐变
}

class ZJPopupView: UIView {

    var popupStyle : ZJPopupAnimationStyle? = .ZJPopupSacle
    // 自定义 View
    private lazy var cusView : UIView = {
        let cusView = UIView()
        cusView.backgroundColor = kWhite
        cusView.layer.cornerRadius = 5
        return cusView;
    }()
    
    var durationTime : Double = 0.25
    var bgAlpha : CGFloat = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        self.backgroundColor = colorWithRGBA(33, 33, 33, bgAlpha)
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        UIApplication.shared.keyWindow?.addSubview(self)
        setUpAllView()
        
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(zj_dissPopView))
        self.addGestureRecognizer(bgTap)
        
        let cusTap = UITapGestureRecognizer(target: self, action: #selector(zj_cusTap))
        cusView.addGestureRecognizer(cusTap)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 显示弹窗
    func zj_showPopView() {
        
        self.alpha = 0.0
        self.isHidden = false
        self.cusView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: durationTime, animations: {
            self.alpha = 1.0
            self.cusView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (isSuccess) in
            
        }
        
    }
    
    // 隐藏弹窗
    @objc func zj_dissPopView(){
        
        UIView.animate(withDuration: durationTime, animations: {
            self.alpha = 0.0
            self.cusView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (isSuccess) in
            self.isHidden = true
        }
    }
    
    
    @objc func zj_cusTap() {
        
    }
}


// 配置 UI 视图
extension ZJPopupView {
    
    private func setUpAllView() {
        self.addSubview(cusView)
        cusView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(kScreenW - 100)
            make.height.equalTo(kScreenH - 200)
        }
    }
    
    
}
