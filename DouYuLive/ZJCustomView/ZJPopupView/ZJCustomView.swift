//
//  ZJCustomView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/10/4.
//  Copyright © 2018 邓志坚. All rights reserved.
//

import UIKit

class ZJCustomView: ZJPopupBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        self.layer.cornerRadius = 5
        let btn = UIButton.zj_createButton(title: "这是一个自定义弹窗视图,点击关闭", titleStatu: .normal, imageName: nil, imageStatu: nil, supView: self) { (make) in
            make.center.equalTo(self.snp.center)
        }
        // 添加zj_popupViewhiddenAction 事件,点击隐藏视图
        btn.addTarget(self, action: #selector(zj_popupViewhiddenAction), for: .touchUpInside)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
