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
    lazy var cusView : UIView = {
        let cusView = UIView()
        cusView.backgroundColor = kWhite
        cusView.layer.cornerRadius = 5
        return cusView;
    }()
    
    var durationTime : Double = 0.25
    var bgAlpha : CGFloat = 0.5
    
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - size: 视图尺寸宽高
    ///   - customView: 自定义视图
    ///   - style: 动画样式
    init(size: CGSize, customView: UIView? = nil ,style : ZJPopupAnimationStyle) {
        super.init(frame:UIScreen.main.bounds)
        popupStyle = style
        self.isHidden = true
        self.backgroundColor = colorWithRGBA(33, 33, 33, bgAlpha)
        self.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        if customView != nil { self.cusView = customView! }
        UIApplication.shared.keyWindow?.addSubview(self)
        setUpAllView(size: size)
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(zj_dissPopView))
        self.addGestureRecognizer(bgTap)
        
        let cusTap = UITapGestureRecognizer(target: self, action: #selector(zj_cusTap))
        self.cusView.addGestureRecognizer(cusTap)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 显示弹窗
    func zj_showPopView() {
        self.alpha = 0.0
        self.isHidden = false

        
        switch popupStyle {
        case .ZJPopTransition?:
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 1.0
                self.cusView.transform = self.cusView.transform.concatenating(CGAffineTransform(translationX: 100, y: 100))
            }) { (isSuccess) in
                
            }
            break
        case .ZJRotation?:
            break
        case .ZJPopupSacle?:
            self.cusView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 1.0
                self.cusView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (isSuccess) in
                
            }
            break
        case .ZJAlpha?:
            break
        default:
            break
            
        }
        
        
    }
    
    // 隐藏弹窗
    @objc func zj_dissPopView(){
        
        switch popupStyle {
        case .ZJPopTransition?:
            break
        case .ZJRotation?:
            break
        case .ZJPopupSacle?:
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.cusView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            break
        case .ZJAlpha?:
            break
        default:
            break
            
        }
        
        
    }
    
    
    @objc func zj_cusTap() {
        
    }
}


// 配置 UI 视图
extension ZJPopupView {
    
    private func setUpAllView(size: CGSize) {
        self.addSubview(cusView)
        
        cusView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
    }
    
    
}
