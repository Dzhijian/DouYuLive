//
//  ZJDiscoverModel.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

/*
 {
 "error": 0,
 "data": [{
 "room_id": "5281681",
 "distance": "3972.3",
 "subject": "",
 "vertical_src": "https:\/\/rpic.douyucdn.cn\/live-cover\/appCovers\/2018\/07\/08\/5281681_20180708204954_big.jpg",
 "push_ios": "1",
 "last_close_time": "-1",
 "game_name": "\u989c\u503c",
 "vod_quality": "0",
 "owner_uid": "210936567",
 "rpos": "61",
 "nickname": "\u4f60\u7684\u51cc\u7199\u554a",
 "show_status": "1",
 "avatar_mid": "https:\/\/apic.douyucdn.cn\/upload\/avatar_v3\/201807\/d6b797636c0d03f07a7d0e30609c1f7b_middle.jpg",
 "recomType": "0",
 "cate_id": "201",
 "avatar": "https:\/\/apic.douyucdn.cn\/upload\/avatar_v3\/201807\/d6b797636c0d03f07a7d0e30609c1f7b_big.jpg",
 "avatar_small": "https:\/\/apic.douyucdn.cn\/upload\/avatar_v3\/201807\/d6b797636c0d03f07a7d0e30609c1f7b_small.jpg",
 "specific_status": "0",
 "room_src": "https:\/\/rpic.douyucdn.cn\/live-cover\/appCovers\/2018\/07\/08\/5281681_20180708204954_small.jpg",
 "room_name": "\u4e00\u500b\u4eba\u7684\u591c\u6211\u7684\u5fc3\u61c9\u8a72\u653e\u5728\u54ea\u88e1",
 "game_url": "\/directory\/game\/yz",
 "child_id": "0",
 "isVertical": 1,
 "ranktype": "61",
 "online": 6000,
 "specific_catalog": "",
 "anchor_city": "\u6df1\u5733\u5e02",
 "jumpUrl": "",
 "url": "\/5281681",
 "nrt": 0,
 "is_noble_rec": 0,
 "rmf1": 0,
 "rmf2": 0,
 "rmf3": 0,
 "rmf4": 0,
 "rmf5": 0
 }
 */

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
