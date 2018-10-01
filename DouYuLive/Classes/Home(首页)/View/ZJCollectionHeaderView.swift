//
//  ZJCollectionHeaderView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/1.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCollectionHeaderView: UICollectionReusableView {
    lazy var titleLab = UILabel()
    lazy var topLine : UIView = UIView()
    lazy var botLine : UIView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        backgroundColor = kWhite
    }
    
    func configTitle(title : String) {
        titleLab.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZJCollectionHeaderView {
    
    private func setUpView(){
        
        topLine = UIView.zj_createView(bgClor: klineColor, supView: self, closure: { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.6)
        })
        
        titleLab = UILabel.zj_createLabel(text: "", textColor: kMainTextColor, font: BoldFontSize(16), supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(AdaptW(15))
        })
        
        botLine = UIView.zj_createView(bgClor: klineColor, supView: self, closure: { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.6)
        })
    }
}
