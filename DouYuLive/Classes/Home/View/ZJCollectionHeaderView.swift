//
//  ZJCollectionHeaderView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCollectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        backgroundColor = kWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZJCollectionHeaderView {
    
    private func setUpView(){
        
        _ = UILabel.zj_createLabel(text: "精彩推荐", textColor: UIColor.black, font: BoldFontSize(16), supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(AdaptW(20))
        })
    }
}
