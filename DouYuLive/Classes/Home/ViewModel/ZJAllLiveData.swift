
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
    var list : [ZJAllLiveList]  = Array<ZJAllLiveList>()
//    var ct : String?
    
}

struct ZJAllLiveList : Decodable {
    var room_id : Int64?
    var room_name : String?
    var nickname : String?
    var cate_id : Int32?
    var cate2_name : String?
    var room_src : String?
    var is_vertical : Int32?
    var online_num : Int64?
    var hn : Int32?
    var show_status : Int32?
    var bid_id : Int32?
    var bidToken : String?
//    var rpos : String?
//    var rankType : String?
//    var recomType : String?
//    var show_id : String?
//    var iho : String?
//    var guild_id : String?
//    var topid : String?
//    var chanid : String?
//    var nrt : String?
//    var icon_url : String?
//    var noble_rec_nickname : String?
//    var noble_rec_user_id : String?
}
/*
 "room_id":288016,
 "room_name":"LPL夏季赛 8月8日重播",
 "nickname":"英雄联盟官方赛事",
 "cate_id":1,
 "cate2_name":"英雄联盟",
 "room_src":"https://rpic.douyucdn.cn/asrpic/180809/288016_1038.jpg",
 "is_vertical":0,
 "vertical_src":"https://rpic.douyucdn.cn/asrpic/180809/288016_1038.jpg",
 "online_num":1945177,
 "hn":1945177,
 "show_status":1,
 "bid_id":0,
 "bidToken":"",
 "rpos":0,
 "rankType":0,
 "recomType":0,
 "show_id":"99210995",
 "iho":0,
 "guild_id":0,
 "topid":0,
 "chanid":0,
 "nrt":0,
 "wt":0,
 "icdata":Array[4],
 "jump_url":"",
 "client_sys":0,
 "is_noble_rec":0,
 "noble_rec_user_id":0,
 "noble_rec_nickname":"",
 "anchor_city":"",
 "rmf1":0,
 "rmf2":0,
 "rmf3":0,
 "rmf5":0,
 "rmf6":0,
 "rmf7":0,
 "rmf8":0,
 "ofc":0,
 "lhl":0,
 "chgd":0,
 "has_al":0,
 "anchor_label":Array[0],
 "icon_url":"",
 "nly":0
 */
