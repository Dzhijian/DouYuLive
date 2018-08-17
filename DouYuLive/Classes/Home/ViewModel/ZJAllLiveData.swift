
//
//  ZJAllLiveData.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/9.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
/*
 "roomRule":0,
 "msg":"",
 "list
 */
struct ZJLiveListData : Decodable{
    var roomRule : Int32?
    var msg : String?
    var list : [ZJLiveItemModel]  = Array<ZJLiveItemModel>()
    var ct : ZJLiveCTModel = ZJLiveCTModel()
    
}

struct ZJLiveItemModel : Decodable {
    var room_id : Int64?
    var room_name : String?
    var nickname : String?
    var cate_id : Int32?
    var cate2_name : String?
    var room_src : String?
    var is_vertical : Int32?
    var vertical_src : String?
    var online_num : Int32?
    var show_status : Int32?
    var bid_id : Int32?
    var bidToken : String?
    var rpos : Int32?
    var rankType : Int32?
    var recomType : Int32?
    var show_id : String?
    var noble_rec_user_id : Int32?
    var noble_rec_nickname : String?
    var anchor_city : String?
}

/*
 "iv":0,
 "tag":0,
 "tn":"",
 "wt":0
 */
struct ZJLiveCTModel : Decodable {
    var iv : Int64?
    var tag : Int32?
    var tn : String?
    var wt : Int32?
    
}

struct ZJLiveListIcdata : Decodable {
    //    var id : Int?
    var url : String?
    
}

