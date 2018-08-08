
//
//  ZJBannerModel.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/8.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
/*
 "num":0,
 "count":4,
 "slide_list":[]
 */
struct ZJCateBanner : Decodable{
    var num : Int32?
    var count : Int32?
    var slide_list : [ZJBannerList] = Array<ZJBannerList>()
    
    
}

/*
 "cate_id":1,
 "title":"英雄联盟",
 "level":0,
 "resource":"https://sta-op.douyucdn.cn/dypart/2018/07/31/3118678d87b677bc517ff07e655efc1c.jpg",
 "link_type":0,
 "link":"288016",
 "is_room_show":0,
 "isVertical":0,
 "vertical_src":"https://rpic.douyucdn.cn/asrpic/180808/288016_0055.jpg",
 "nrt":0
 */
struct ZJBannerList : Decodable{
    var cate_id : Int32?
    var level : Int32?
    var link_type : Int32?
    var is_room_show : Int32?
    var isVertical : Int32?
    var nrt : Int32?
    var title : String?
    var resource : String?
    var vertical_src : String?
    var link : String?
}
