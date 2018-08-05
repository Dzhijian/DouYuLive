
//
//  ZJBaseTableCell.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/5.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJBaseTableCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        zj_setUpAllView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 配置子控件
    public func zj_setUpAllView(){
        self.selectionStyle = .none
        self.accessoryType =  .none
        self.contentView.backgroundColor = kWhite
    }
    
    public class func cellHeight() -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public class func cellHeightWithModel(model : Any) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public class func identifier() -> String {
        
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
