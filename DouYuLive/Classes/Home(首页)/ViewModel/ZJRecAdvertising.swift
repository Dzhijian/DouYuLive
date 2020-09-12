//
//  ZJRecAdvertising.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2020/4/8.
//  Copyright © 2020 邓志坚. All rights reserved.
//

import UIKit
//
/// 转换成数组模型
struct ZJRecAdvertising: Decodable {
    /// 状态值
    var error : Int64?
    /// 嵌套模型
    var data : [ZJRecAdvertisingList] = [ZJRecAdvertisingList]()
    var msg : String?

}

struct ZJRecAdvertisingList: Decodable {
    var id : Int8?
    var main_id : Int8?
    var oa_source : Int?
    var pic_url : String?
    var room : ZJRecAdvertisingListRoom? = ZJRecAdvertisingListRoom()
    var source : String?
    var title : String?

}

struct ZJRecAdvertisingListRoom: Decodable {
    var cate_id : Int?
    var isVertical : Bool?
    var nrt : Int?
    var room_id : String?
    var room_src : String?
    var vertical_src : String?

}



//struct ZJRecAdvertisingDataList : Decodable {
//    var act_button_text : String?
//    var act_end_time : NSInteger?
//    var act_info : String?
//    var act_name : String?
//    var act_start_time : NSInteger?
//    var act_url : String?
//    var act_button_text : String?
//    var act_button_text : String?
//
//    var act_button_text : String?
//
//}

