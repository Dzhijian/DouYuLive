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

class ZJPopupView: UIView,ZJPopupViewDelegate {

    var popupStyle : ZJPopupAnimationStyle? = .ZJPopupSacle
    // 自定义 View
    lazy var cusView : ZJPopupBaseCustomView = {
        let cusView = ZJPopupBaseCustomView()
        cusView.backgroundColor = kWhite
        cusView.layer.cornerRadius = 5
        return cusView;
    }()
    /// 是否可以点击透明背景层,默认为 true
    var isBGClickAction : Bool = true
//        didSet{
//            if isBGClickAction {
//                self.addGestureRecognizer(bgTap)
//            }else{
//                self.removeGestureRecognizer(bgTap)
//            }
//        }
//    }
    // 动画时间
    var durationTime : Double = 0.25
    // 背景透明度
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
        if customView != nil { self.cusView = customView! as! ZJPopupBaseCustomView }
        UIApplication.shared.keyWindow?.addSubview(self)
        
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(zj_dissmissPopView))
        self.addGestureRecognizer(bgTap)
        // 配置 UI ,设置 size
        setUpAllView(size: size)
        // 背景层点击事件
        // 自定义视图点击事件,默认不做处理
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
            
            self.alpha = 1.0
            
            // 旋转缩放动画使用 CABasicAnimation 基本动画实现
            let scaleAnima = CABasicAnimation(keyPath: "transform.scale")
            // 0.2 -> 1.0
            scaleAnima.toValue = 1.0
            scaleAnima.fromValue = 0.2
            
            let rotaAnima = CABasicAnimation(keyPath: "transform.rotation.z")
            rotaAnima.toValue = Double.pi * 2
            // 组动画
            let groupAnima = CAAnimationGroup()
            groupAnima.animations = [scaleAnima,rotaAnima]
            groupAnima.duration = durationTime*2
            // 添加到 layer 上
            self.cusView.layer.add(groupAnima, forKey: "groupAnimation")
            
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
            self.cusView.alpha = 0.0
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 1.0
                self.cusView.alpha = 1.0
            }) { (isSuccess) in
                
            }
            break
        default:
            break
            
        }
        
        
    }
    
    // 隐藏弹窗
    @objc func zj_dissmissPopView(){
        
        switch popupStyle {
        case .ZJPopTransition?:
            break
        case .ZJRotation?:
            
            UIView.animate(withDuration: durationTime, animations: {
                self.alpha = 0.0
                self.cusView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { (isSuccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
            
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
            UIView.animate(withDuration: durationTime, animations: {
                self.cusView.alpha = 0.0
            }) { (isSccess) in
                self.isHidden = true
                self.removeFromSuperview()
            }
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
