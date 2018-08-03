//
//  ZJHomeSearchView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/27.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJHomeSearchView : UIView {
    
    lazy var textField : UITextField = { () -> UITextField in
        let textField = UITextField()
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = .none
        textField.font = FontSize(14)
        textField.placeholder = "请输入搜索内容"
        return textField
    }()
    var searchIcon : UIImageView = { () -> UIImageView in
       let searchIcon = UIImageView()
        searchIcon.image = UIImage(named: "home_newSeacrhcon")
        searchIcon.contentMode = .center
        return searchIcon
    }()
    var QcodeIcon  : UIImageView = { () -> UIImageView in
        let QcodeIcon = UIImageView()
        QcodeIcon.image = UIImage(named: "home_newSaoicon")
        QcodeIcon.contentMode = .center
        return QcodeIcon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        setUpChildView()
        
    }
    
    
     func setUpChildView() {
        
        self.addSubview(textField)
        self.addSubview(searchIcon)
        self.addSubview(QcodeIcon)

        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(AdaptW(35))
            make.right.equalTo(self).offset(AdaptW(-35))
            make.height.equalTo(30)
            make.center.equalTo(self)
        }
        searchIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(5)
            make.width.height.equalTo(AdaptW(30))
        }
        
        QcodeIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(AdaptW(-5))
            make.width.height.equalTo(AdaptW(30))
        }
        
    
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
