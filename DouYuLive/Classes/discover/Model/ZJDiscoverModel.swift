//
//  ZJDiscoverModel.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct ZJNearFaceScoreData : Decodable {
    var error : Int?
    var data : [ZJNearFaceScoreList] = [ZJNearFaceScoreList]()
}
struct ZJNearFaceScoreList : Decodable {
    
    var room_id : String?
    var distance : String?
    var subject : String?
    var vertical_src : String?
    var push_ios : String?
    var last_close_time : String?
    var game_name : String?
    var vod_quality : String?
    var owner_uid : String?
    var rpos : String?
    var nickname : String?
    var show_status : String?
    var avatar_mid : String?
    var recomType : String?
    var cate_id : String?
    var avatar : String?
    var avatar_small : String?
    var specific_status : String?
    var room_src : String?
    var room_name : String?
    var game_url : String?
    var child_id : String?
    var isVertical : Int?
    var ranktype : String?
    var online : Int?
    var specific_catalog : String?
    var anchor_city : String?
    var jumpUrl : String?
    var url : String?
    var nrt : Int?
    var is_noble_rec : String?

}


struct ZJAnchorRankData : Decodable {
    
    var error : Int?
    var data : [ZJAnchorRankList] = [ZJAnchorRankList]()
}
/*
 "statu": 2,
 "ttl": 1372,
 "title": "\u4e4b\u524d\u672a\u4e0a\u699c",
 "uid": "204389",
 "avatar": "https:\/\/apic.douyucdn.cn\/upload\/avanew\/face\/201803\/23\/17\/faa711e232041d7525a1bd695bf8fa8e_middle.jpg?rltime",
 "nickname": "yyfyyf",
 "is_live": true,
 "id": 1,
 "room_id": "9999",
 "catagory": "DOTA2",
 "sc": 1128446,
 "anchorLevelInfo": {
 "level": "100"
 },
 "diff": 0,
 "isVertical": 0,
 "vertical_src": "",
 "nrt": 0
 */
struct ZJAnchorRankList : Decodable {
    var statu : Int?
    var ttl : Int?
    var title : String?
    var uid : String?
    var avatar : String?
    var nickname : String?
    var is_live : String?
    var id : Int?
    var room_id : String?
    var catagory : String?
    var sc : Int?
    var diff : Int?
    var isVertical : Int?
    var nrt : Int?
    var vertical_src : String?

}


