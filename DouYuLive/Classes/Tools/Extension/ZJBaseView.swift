
//
//  ZJView+SnapKit.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/30.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    /// 快速创建 View 并使用 SnapKit 布局
    ///
    /// - Parameters:
    ///   - bgClor: View 的背景颜色
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  View
    class func zj_createView(bgClor : UIColor , supView : UIView? ,closure:(_ make:ConstraintMaker) ->()) -> UIView {
        let view = UIView()
        view.backgroundColor = bgClor
        
        if supView != nil {
            supView?.addSubview(view)
            view.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        
        return view
    }
    
    /// 快速创建一个 UIImageView,可以设置 imageName,contentMode,父视图,约束
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - contentMode: 填充模式
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  UIImageView
    class func zj_createImageView(imageName : String? , contentMode : UIViewContentMode?,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UIImageView {
        
        let imageV = UIImageView()
        
        if imageName != nil {
            imageV.image = UIImage(named: imageName!)
        }
        
        if contentMode != nil {
            imageV.contentMode = contentMode!
        }
        
        if supView != nil {
            supView?.addSubview(imageV)
            imageV.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return imageV
    }
    
    
    /// 快速创建 UIButton,设置标题,图片,父视图,约束
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleStatu: 标题状态模式
    ///   - imageName: 图片名
    ///   - imageStatu: 图片状态模式
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  UIButton
    class func zj_createButton(title : String?,titleStatu : UIControlState?,imageName : String?,imageStatu : UIControlState?,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UIButton{
        let btn = UIButton()
        
        if title != nil {
            btn.setTitle(title, for: .normal)
        }
        
        if title != nil && titleStatu != nil {
            btn.setTitle(title, for: titleStatu!)
        }
        
        if imageName != nil {
            btn.setImage(UIImage(named: imageName!), for: .normal)
        }
        
        if imageName != nil && imageStatu != nil {
           btn.setImage(UIImage(named: imageName!), for: imageStatu!)
        }
        
        if supView != nil {
            supView?.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return btn
    }
}
