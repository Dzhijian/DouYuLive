//
//  ZJHomeSearchView.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/27.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJHomeSearchView: UIView {
    
    lazy var textField : UITextField = { () -> UITextField in
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .none
        
        return textField
    }()
    var backView = UIView()
    var searchIcon = UIImageView()
    var QcodeIcon = UIImageView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUpChildView()
        
    }
    
    
    
    private func setUpChildView() {
        backView.backgroundColor = UIColor.red
        self.addSubview(backView)
        backView .addSubview(textField)
        backView.addSubview(searchIcon)
        backView.addSubview(QcodeIcon)
        backView.layer.borderColor = UIColor.white.cgColor
        backView.layer.borderWidth = 1
        backView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(35)
            make.center.equalTo(self)
        }
        
        textField.snp.makeConstraints { (make) in
            make.center.equalTo(backView)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
