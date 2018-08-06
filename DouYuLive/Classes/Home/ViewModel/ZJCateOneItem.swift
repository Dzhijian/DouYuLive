//
//  ZJCateOneItem.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/6.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

struct  ZJCateOneItem: Decodable {
    var cate1_id : Int32?
    var cate_name : String?
    var cate2_count : Int32?
    var cate2_list : [ZJCategoryList] = [ZJCategoryList]()
}
