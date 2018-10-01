//
//  ZJDiscoverSectionHeadView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/17.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJDiscoverSectionHeadView: UICollectionReusableView {
    
    lazy var titleLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kMainTextColor
        lab.font = BoldFontSize(15)
        
        return lab
    }()
    
    func configTitle(title: String) {
        
        titleLab.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 配置 UI
extension ZJDiscoverSectionHeadView {
    
    private func setUpAllView() {
        addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(15))
        }
    }
}
