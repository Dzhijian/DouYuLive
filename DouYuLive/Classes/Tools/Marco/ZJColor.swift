//
//  ZJColor.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/30.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


let kWhite       = UIColor.white
let kRed         = UIColor.red
let kOrange      = UIColor.orange
let kBlack       = UIColor.black
let kGreen       = UIColor.green
let kPurple      = UIColor.purple
let kBlue        = UIColor.blue

// 主颜色 MainOrange
let kMainOrangeColor = UIColor(red: colorValue(238.0), green:colorValue(120.0), blue: colorValue(59), alpha: 1.0)

// low  r: 239 130 62
// high r: 237 105 57
let kLowOrangeColor = UIColor(red: colorValue(239), green:colorValue(130), blue: colorValue(62), alpha: 1.0)
let kHighOrangeColor = UIColor(red: colorValue(237), green:colorValue(105), blue: colorValue(57), alpha: 1.0)
// 渐变色色组
let kGradientColors: [CGColor] = [kLowOrangeColor.cgColor, kHighOrangeColor.cgColor]
// 搜索框背景颜色 e
let kSearchBGColor = UIColor(red: colorValue(237.0), green:colorValue(143.0), blue: colorValue(90), alpha: 1.0)

// 分割线的颜色
let klineColor : UIColor = colorWithRGBA(230, 230, 230, 1.0)
// 文字颜色
let kMainTextColor : UIColor = colorWithRGBA(33, 33, 33, 1.0)
// 文字颜色
let kGrayTextColor : UIColor = colorWithRGBA(99, 99, 99, 1.0)
// 文字颜色
let kLowGrayColor : UIColor = colorWithRGBA(150, 150, 150, 1.0)

// function
// 背景灰色
let kBGGrayColor : UIColor = colorWithRGBA(247, 247, 247, 1.0)
func colorValue(_ value : CGFloat) -> CGFloat {
    return value / 255.0
}


/// UIColor,通过 RGBA数值设置颜色
///
/// - Parameters:
///   - red: 红色值
///   - green: 绿色值
///   - blue: 蓝色值
///   - alpha: 透明度
/// - Returns:  UIColor
func colorWithRGBA(_ red : CGFloat,_ green : CGFloat , _ blue : CGFloat,_ alpha : CGFloat) -> UIColor{
    
    return UIColor(red: colorValue(red), green: colorValue(green), blue: colorValue(blue), alpha: alpha)
}

