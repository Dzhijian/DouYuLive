//
//  ZJPageTitleView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/27.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJPageTitleView: UIView {

    private var titles : [String]
    init(frame : CGRect , titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
