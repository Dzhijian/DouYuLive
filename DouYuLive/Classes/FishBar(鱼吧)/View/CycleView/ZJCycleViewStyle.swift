//
//  ZJCycleViewStyle.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/20.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

class ZJCycleViewStyle {
    // 是否开启无限轮播,默认开启
    var kIsInfiniteLoop : Bool? = true
    // 是否开启缩放
    var kIsScaleView : Bool? = true
    // 是否开启自动滚动
    var kIsAutoScroll : Bool? = true
    // 自动滚动时间间隔
    var autoScrollTimeInterval : CGFloat? = 2
    // cell 宽度
    var kItemWidth : CGFloat? = kScreenW - 100
    // cell 的间距
    var kItemMargin : CGFloat? = 0
    // 占位图
    var placeholderImage : UIImage?
    // 图片圆角
    var imgCornerRadius : CGFloat? = 3
    // 分页控制器
    var pageControl : UIPageControl?
    // 是否显示分页控制器
    var kIsShowPageControl : Bool? = true
    // 图片的填充模式
    var  ImageContentMode : UIViewContentMode? = .scaleAspectFill
}
