//
//  ZJBaseCustomView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/10/6.
//  Copyright © 2018 邓志坚. All rights reserved.
//

import UIKit

class ZJPopupBaseView: UIView {
    // 定义一个无参数无返回值的闭包
    typealias CusHiddenBlock = ()->()
    var cusBlock : CusHiddenBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 回调给 popupView 隐藏视图
    @objc func zj_popupViewhiddenAction() {
        if cusBlock != nil {
            cusBlock!()
        }
    }
}
