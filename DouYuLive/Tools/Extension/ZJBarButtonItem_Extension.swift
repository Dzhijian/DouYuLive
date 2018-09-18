//
//  ZJBarButtonItem-Extension.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/26.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    // 类方法创建UIBarButtonItem
    class func createBarButton(_ norImageName : String,_ highLightImageName : String, _ size : CGSize) -> UIBarButtonItem {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: norImageName) , for: .normal)
        btn.setImage(UIImage(named: highLightImageName) , for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
        
    }
    
    
    // 实例方法创建,便利构造函数: 1.必须使用 convenience 2.在构造函数中必须使用一个设计的构造函数self
    convenience init(norImageName : String, highLightImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: norImageName) , for: .normal)
        
        if highLightImageName != "" {
            
            btn.setImage(UIImage(named: highLightImageName) , for: .highlighted)
        }
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}
