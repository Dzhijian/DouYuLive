//
//  ZJBaseView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJBaseView: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 配置所有子视图
        zj_initWithAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func zj_initWithAllView() {
        
    }
    
}
