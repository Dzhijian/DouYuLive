
//
//  ZJChildCateList.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit


//struct ZJChildCateData : Codable {
//    var error : Int32?
//    var data : [ZJChildCateList] = Array<ZJChildCateList>()
//    
//}

/// 转换成数组模型
struct ZJChildCateData: Decodable {
    /// 状态值
    var error : Int64?
    /// 嵌套模型
    var data:[ZJChildCateList] = Array<ZJChildCateList>()
}

struct ZJChildCateList : Codable {
    
    var id : String?
    var name : String?
}

