//
//  ZJBaseCollectionCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJBaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        zj_setUpAllView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func zj_setUpAllView() {
        self.contentView.backgroundColor = kWhite
    }
    
    public class func itemHeight() -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public class func itemHeightWithModel(model : Any) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public class func identifier() -> String {
        
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
        
    }
    
}
