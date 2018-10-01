//
//  ZJFollowVideoData.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/17.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct ZJFollowVideoData : Decodable {
    var error : Int?
    var data : [ZJFollowVideoList] = [ZJFollowVideoList]()
}

/*
 up_id: "zPDAPNnvwxNG",
 nickname: "阿冷aleng丶",
 owner_avatar: "https://apic.douyucdn.cn/upload/avanew/face/201803/21/14/ca8ff6af98f5252b3f3e0f00165b163b_middle.jpg?rltime_middle.jpg",
 utime: 1534408740,
 video_duration: 212.96,
 video_str_duration: "03:32",
 video_title: "阿冷《突然想起你》❤",
 video_content: "",
 video_cover: "https://sta-op.douyucdn.cn/vod-cover/2018/08/16/77370ad347cef6e2f681b848792ce1ef.jpg",
 video_vertical_cover: "https://sta-op.douyucdn.cn/vod-cover/2018/08/16/4e3867909b734a481918a18fef5026e5.jpg",
 is_vertical: 0,
 rpos: "74",
 rt: "74",
 sub_rt: "1",
 hash_id: "Drwnvzy0LRoWPNaX",
 point_id: 5502888,
 video_status: 0,
 topic_title: "",
 video_up_num: 0,
 video_collect_num: 0,
 barrage_num: 0,
 comment_num: 47,
 view_num: 30049,
 owner_auth_type: 0,
 cid2: 5,
 cate2_name: "英雄联盟"
 */
struct ZJFollowVideoList : Decodable {
    var up_id : String?
    var nickname : String?
    var owner_avatar : String?
    var utime : Int?
    var video_duration : Float?
    var video_str_duration : String?
    var video_title : String?
    var video_content : String?
    var video_cover : String?
    var video_vertical_cover : String?
    var is_vertical : Int?
    var rpos : String?
    var rt : String?
    var sub_rt : String?
    var hash_id : String?
    var point_id : Int?
    var video_status : Int?
    var topic_title : String?
    var video_up_num : Int?
    var barrage_num : Int?
    var comment_num : Int?
    var view_num : Int?
    var owner_auth_type : Int?
    var cid2 : Int?
    var cid1 : Int?
    var uid : Int?
    var cate2_name : String?
    var video_collect_num : Int?
    
}
