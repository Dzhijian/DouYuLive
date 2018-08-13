//
//  ZJInterfaceURL.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/2.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import Foundation

// 热门推荐
let ZJRecommendHotURL : String = "https://apiv2.douyucdn.cn/mgapi/livenc/home/getRecList1"

let ZJActivityListURL : String = "https://apiv2.douyucdn.cn/Live/Subactivity/getActivityList?client_sys=ios&cid2=0"

let ZJSignAppURL : String = "https://rtbapi.douyucdn.cn/japi/sign/app/getinfo?uid=&client_sys=ios&mdid=iphone"
// 首页推荐分类
// https://apiv2.douyucdn.cn/live/Cate/getTabCate1List?client_sys=ios

// 分类推荐列表
let ZJRecommendCategoryURL : String = "https://apiv2.douyucdn.cn/live/cate/getLiveRecommendCate2?client_sys=ios"

let ZJLiveCateURL : String = "https://apiv2.douyucdn.cn/live/cate/getLiveCate1List?client_sys=ios"

// banner
//https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=1&app_ver=4610000&client_sys=ios get
let ZJCateBannerURL : String = "https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=1&app_ver=4610000&client_sys=ios"

// 子类下的直播分类
//https://capi.douyucdn.cn/api/v1/getThreeCate?client_sys=ios&tag_id=1 get
let ZJChildCateListURL = "https://capi.douyucdn.cn/api/v1/getThreeCate?client_sys=ios&tag_id=1"


// 子类下的分类
//https://apiv2.douyucdn.cn/Live/Customcate2/getAllComponentList?cate2_id=1&client_sys=ios get
//let ZJLOLCateListURL = "https://apiv2.douyucdn.cn/Live/Customcate2/getAllComponentList?cate2_id=1&client_sys=ios"
// 直播列表
// https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_1/0/20/ios?client_sys=ios get
//https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/3_168/0/20/ios?client_sys=ios get
//https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/3_32/0/20/ios?client_sys=ios get
//                      /2_1/0/20/ios?client_sys=ios
let ZJLOLLiveListURL = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist"

// 全部列表
// https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/0_0/0/20/ios?client_sys=ios get
let ZJAllLiveListURL = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/0_0/0/20/ios?client_sys=ios"

// 视频列表
//https://apiv2.douyucdn.cn/mgapi/vodnc/front/vodlist/cate2VodList?offset=0&client_sys=ios&cate2_id=5&limit=10
//https://apiv2.douyucdn.cn/video/videoInfo/getDanmu?vid=XqeO74xrVDQ7xywG&client_sys=ios

let ZJVideoListURL = "https://apiv2.douyucdn.cn/mgapi/vodnc/front/vodlist/cate2VodList?offset=0&client_sys=ios&cate2_id=5&limit=10"


// 娱乐 Tab 的子分类
//https://apiv2.douyucdn.cn/live/cate/getTabCate1List1?client_sys=ios
let RecreationChildCateURL = "https://apiv2.douyucdn.cn/live/cate/getTabCate1List1?client_sys=ios"


// 关注 可能感兴趣列表
// https://apiv2.douyucdn.cn/live/recom/getFwRecRoomList?client_sys=ios
