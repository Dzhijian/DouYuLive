//
//  ZJRecreationCateList.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/13.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct ZJRecreationCateData : Decodable{
    /// 状态值
    var error : Int64?
    /// 嵌套模型
    var data:[ZJRecreationCateList] = Array<ZJRecreationCateList>()
}

struct ZJRecreationCateList : Decodable{
    var cate_id : Int64?
    var cate_name : String?
    var level : Int32?
    var push_ios : String?
    var push_nearby : String?
    var short_name : String?
    var tab_id : Int64?
    var push_vertical_screen : String?
    
}
