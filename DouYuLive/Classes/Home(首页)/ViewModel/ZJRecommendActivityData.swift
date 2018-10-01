//
//  ZJRecommendActivityData.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/18.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct ZJRecommendActivityData : Decodable {
    var total : Int?
    var list : [ZJRecommendActivityList] = [ZJRecommendActivityList]()
}

/*
 
 "act_button_text" = "";
 "act_end_time" = 1534948200;
 "act_info" = "\U95ea\U7535\U718a\U4e8c\U5b88\U64c2\U6218\Uff0c\U8fd9\U662f\U4e00\U573a\U5b9e\U529b\U6d3e\U4e4b\U95f4\U7684\U7cbe\U5f69\U8f83\U91cf\Uff01";
 "act_name" = "\U6597\U9c7cLIVE\U97f3\U4e50\U64c2\U53f0";
 "act_start_time" = 1534937400;
 "act_url" = "";
 cid2 = 0;
 id = 1288;
 "is_vertical" = 0;
 nrt = 0;
 "room_id" = 5238090;
 "room_src" = "https://rpic.douyucdn.cn/live-cover/roomCover/2018/08/01/d8266b8bc88ab3b8f4877fcd90b1d8da_big.jpg";
 "sub_num" = 11242;
 "vertical_src" = "https://rpic.douyucdn.cn/live-cover/roomCover/2018/08/01/d8266b8bc88ab3b8f4877fcd90b1d8da_small.jpg";
 */
struct ZJRecommendActivityList : Decodable {
    var act_button_text : String?
    var act_end_time : Int?
    var act_info : String?
    var act_name : String?
    var act_start_time : Int?
    var act_url : String?
    var cid2 : Int?
    var id : Int?
    var is_vertical : Int?
    var nrt : String?
    var room_id : Int?
    var room_src : String?
    var sub_num : Int?
    var vertical_src : String?
    
}

