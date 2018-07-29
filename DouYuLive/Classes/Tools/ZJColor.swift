//
//  ZJColor.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/7/30.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
// 主颜色 Orange

func colorValue(_ value : CGFloat) -> CGFloat {
    return value / 255.0
}

let MainOrangeColor = UIColor(red: colorValue(238.0), green:colorValue(120.0), blue: colorValue(59), alpha: 1.0)

let SearchBGColor = UIColor(red: colorValue(237.0), green:colorValue(143.0), blue: colorValue(90), alpha: 1.0)
