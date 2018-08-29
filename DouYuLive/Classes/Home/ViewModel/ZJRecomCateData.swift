//
//  ZJRecomCateData.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/28.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import ObjectMapper

class ZJRecomCateData: Mappable {

    var total : Int?
    var cate2_list : [ZJRecomCateList] = [ZJRecomCateList]()
    var error : Int?
//    init(){
//    }
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        total  <- map["total"]
        error  <- map["error"]
        cate2_list <- map["cate2_list"]
    }
    
    
}

class ZJRecomCateList: Mappable {
    /*
     "cate2_name" : "汽车",
     "small_icon_url" : "https:\/\/cs-op.douyucdn.cn\/dycatr\/game_cate\/259c981502298cd57757b70d895e3411.png",
     "is_vertical" : 0,
     "icon_url" : "https:\/\/cs-op.douyucdn.cn\/dycatr\/game_cate\/b78528a4925fe48077c88ed433deeaf8.jpg",
     "cate2_id" : 136,
     "cate2_short_name" : "car",
     "push_nearby" : 0,
     "square_icon_url" : "https:\/\/cs-op.douyucdn.cn\/dycatr\/5117d7224aeea3afd40a588c3167e195.png"
     */
    var cate2_name : String?
    var small_icon_url : String?
    var is_vertical : Int?
    var icon_url : String?
    var cate2_id : Int?
    var cate2_short_name : String?
    var push_nearby : Int?
    var square_icon_url : String?
    
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate2_name <- map["cate2_name"]
        small_icon_url <- map["small_icon_url"]
        is_vertical <- map["is_vertical"]
        icon_url <- map["icon_url"]
        cate2_id <- map["cate2_id"]
        cate2_short_name <- map["cate2_short_name"]
        push_nearby <- map["push_nearby"]
        square_icon_url <- map["square_icon_url"]
    }
}


class ZJCateAllData: Mappable {
    
    var cate1_list : [ZJCateOneData] = [ZJCateOneData]()
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate1_list  <- map["cate1_list"]
    }
}

class ZJCateOneData: Mappable {
    
    var cate1_id : Int?
    var cate_name : String?
    var cate2_count : Int?
    var cate2_list : [ZJRecomCateList] = [ZJRecomCateList]()
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate1_id  <- map["cate1_id"]
        cate_name  <- map["cate_name"]
        cate2_count  <- map["cate2_count"]
        cate2_list <- map["cate2_list"]
    }
}
