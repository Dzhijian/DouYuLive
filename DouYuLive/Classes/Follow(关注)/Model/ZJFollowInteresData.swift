//
//  ZJFollowInteresData.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/16.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct ZJFollowInterseData : Decodable {
    var  error : Int?
    var data : [ZJFollowInterseList] = [ZJFollowInterseList]()
}

struct ZJFollowInterseList : Decodable {
    var roomId : Int64?
    var nickname : String?
    var roomName : String?
    var anchorId : String?
    var avatar : String?
    var cate2Id : Int?
    var cate2Name : String?
    var online : Int?
    var isLive : Int?
    var roomSrc : String?
    var isVertical : Int?
    var anchorLevel : Int?
    var followNum : Int?
    var rpos : String?
    var hn : Int?
    var nrt : Int?
    var rt : String?
    var sub_rt : String?
}


struct ZJFollowRankData : Decodable {
    var  error : Int?
    var data : [ZJFollowRankList] = [ZJFollowRankList]()
}

/*
 uid: 2261331,
 avatar: "https://apic.douyucdn.cn/upload/avatar_v3/201808/650168b922e4aae868b29fec672c4fa9_middle.jpg?rltime",
 nickname: "旭旭宝宝",
 is_live: 1,
 room_id: 99999,
 catagory: "DNF",
 anchorLevelInfo: - {
 level: 99
 },
 isVertical: 0,
 vertical_src: "",
 fans_num: 4028722
 */
struct ZJFollowRankList : Decodable {
    var uid : Int64?
    var avatar : String?
    var nickname : String?
    var is_live : Int?
    var room_id : Int64?
    var catagory : String?
    var isVertical : Int?
    var vertical_src : String?
    var fans_num : Int?
}



