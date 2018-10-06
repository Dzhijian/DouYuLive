//
//  ZJBaseCustomView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/10/6.
//  Copyright © 2018 邓志坚. All rights reserved.
//

import UIKit

class ZJPopupBaseCustomView: UIView {

    typealias cusHiddenBlock = ()->()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func popupViewhiddenAction() {
//        if cusHiddenBlock {
//        }
    }
}
