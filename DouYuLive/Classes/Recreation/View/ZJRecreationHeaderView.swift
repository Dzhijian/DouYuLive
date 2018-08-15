//
//  ZJRecreationHeaderView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/13.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJRecreationHeaderView: UICollectionReusableView {
    private lazy var titleLab = UILabel()
    private lazy var icon = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kWhite
        setUpAllView()
    }
    
    // MARK: 配置标题
    func configWithTitle(title : String)  {
        self.titleLab.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension ZJRecreationHeaderView {
    private func setUpAllView (){
        self.titleLab = UILabel.zj_createLabel(text: "标题", textColor: kMainTextColor, font: BoldFontSize(17), supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(Adapt(15))
        })
        
        self.icon = UIImageView.zj_createImageView(imageName: "btn_more", supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.titleLab.snp.right).offset(Adapt(10))
        })
    }
}
