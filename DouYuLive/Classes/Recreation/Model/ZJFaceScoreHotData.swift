//
//  ZJFaceScoreHotData.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/15.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct ZJFaceScoreHotData : Decodable {
    var roomRule : Int?
    var msg : String?
    
    var list : [ZJFaceScoreHotList] = Array<ZJFaceScoreHotList>()
    
    var ct : ZJFaceScoreCT = ZJFaceScoreCT()
}

/*
 "room_id":910907,
 "room_name":"唱歌最好听的人",
 "nickname":"流口水的小熊猫",
 "cate_id":201,
 "cate2_name":"颜值",
 "room_src":"https://rpic.douyucdn.cn/live-cover/appCovers/2018/08/14/910907_20180814204737_small.jpg",
 "is_vertical":1,
 "vertical_src":"https://rpic.douyucdn.cn/live-cover/appCovers/2018/08/14/910907_20180814204737_big.jpg",
 "online_num":156686,
 "hn":156686,
 "show_status":1,
 "bid_id":0,
 "bidToken":"",
 "rpos":0,
 "rankType":1107,
 "recomType":0,
 "show_id":"100579666",
 "noble_rec_user_id":0,
 "noble_rec_nickname":"",
 "anchor_city":"大连市",
 */
struct ZJFaceScoreHotList : Decodable {
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
//    var icdata : [ZJFaceScoreListIcdata] = Array<ZJFaceScoreListIcdata>()
    
}

/*
 "id":102,
 "url":"https://cs-op.douyucdn.cn/dy-listicon/102-1-app.png"
 */
struct ZJFaceScoreListIcdata : Decodable {
//    var id : Int?
    var url : String?
    
}
/*
 "iv":0,
 "tag":0,
 "tn":"",
 "wt":0
 */
struct ZJFaceScoreCT : Decodable {
    var iv : Int64?
    var tag : Int32?
    var tn : String?
    var wt : Int32?
    
}
