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
        textField.font = UIFont.systemFont(ofSize: 14)
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
            make.left.equalTo(self).offset(40)
            make.right.equalTo(self).offset(-40)
            make.height.equalTo(30)
            make.center.equalTo(self)
        }
        searchIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(5)
            make.width.height.equalTo(35)
        }
        
        QcodeIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-5)
            make.width.height.equalTo(35)
        }
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
