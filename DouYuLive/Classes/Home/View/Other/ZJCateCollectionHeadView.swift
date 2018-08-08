//
//  ZJCateCollectionHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCateCollectionHeadView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 配置 UI
extension ZJCateCollectionHeadView {
    
    private func setUpAllView() {
        backgroundColor = kRed
    }
    
}
