//
//  ZJCommon.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/27.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SBCycleScrollView

let ZJ_DOUYU_TOKEN : String = "ZJ_DOUYU_TOKEN"

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height

let kStatuHeight : CGFloat = 20
let kNavigationBarHeight :CGFloat = 44
let kTabBarHeight : CGFloat = 49
let CateItemHeight = kScreenW / 4
let kCateTitleH : CGFloat = 40

let kNavBarHidden : [String:String] = ["isHidden":"true"]

let kNavBarNotHidden : [String:String] = ["isHidden":"false"]

// 自定义索引值
let kBaseTarget : Int = 1000

// 宽度比
let kWidthRatio = kScreenW / 375.0
// 高度比
let kHeightRatio = kScreenH / 667.0

// 自适应
func Adapt(_ value : CGFloat) -> CGFloat {
    
    return AdaptW(value)
}

// 自适应宽度
func AdaptW(_ value : CGFloat) -> CGFloat {
    
    return ceil(value) * kWidthRatio
}


// 自适应高度
func AdaptH(_ value : CGFloat) -> CGFloat {
    
    return ceil(value) * kHeightRatio
}
