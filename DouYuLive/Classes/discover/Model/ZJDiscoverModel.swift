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

struct ZJDiscoverGameData : Decodable{
    var offset : Int?
    var list : [ZJDiscoverGameList] = [ZJDiscoverGameList]()
}

struct ZJDiscoverGameList : Decodable{
    var id : Int?
    var gcid : Int?
    var gid : Int?
    var start_time : Int?
    var match_status : Int?
    var game_name : String?
    var room_show_status : Int?
    var end_flag : Int?
    var player1_id : Int?
    var player2_id : Int?
    var player1_name : String?
    var player2_name : String?
    var player1_icon : String?
    var player2_icon : String?
    var player1_score : Int?
    var player2_score : Int?
    var round : Int?
    var rela_room_id : Int?
    
}

struct ZJDiscoverActivityData : Decodable{
    var total : Int?
    var list : [ZJDiscoverActivityList] = [ZJDiscoverActivityList]()
    
}

struct ZJDiscoverActivityList : Decodable{
    var id : String?
    var act_name : String?
    var act_pic : String?
    var type : String?
    var act_link : String?
    var isVertical : Int?
    var vertical_src : String?
    var nrt : Int?
}


