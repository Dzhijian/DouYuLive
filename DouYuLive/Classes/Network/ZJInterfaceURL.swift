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

// 活动列表
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
let ZJLiveItemModelURL = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/0_0/0/20/ios?client_sys=ios"

// 视频列表
//https://apiv2.douyucdn.cn/mgapi/vodnc/front/vodlist/cate2VodList?offset=0&client_sys=ios&cate2_id=5&limit=10
//https://apiv2.douyucdn.cn/video/videoInfo/getDanmu?vid=XqeO74xrVDQ7xywG&client_sys=ios

let ZJVideoListURL = "https://apiv2.douyucdn.cn/mgapi/vodnc/front/vodlist/cate2VodList?offset=0&client_sys=ios&cate2_id=5&limit=10"


// 娱乐 Tab 的子分类
//https://apiv2.douyucdn.cn/live/cate/getTabCate1List1?client_sys=ios
let RecreationChildCateURL = "https://apiv2.douyucdn.cn/live/cate/getTabCate1List1?client_sys=ios"

// 颜值
// 列表数据 https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/1_8/0/20/ios?client_sys=ios
let ZJFaceScoreListHotURL = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/1_8/0/20/ios?client_sys=ios"


// 看附近 https://capi.douyucdn.cn/api/applivecompanion/getNearbyAnchorNew?aid=ios&cate1_id=0&cate2_id=0&cate3_id=0&client_sys=ios&latitude=22.547960&limit=20&longitude=113.956170&offset=0&time=1534317783&auth=a641e9783ca81e2c954e0deb383416e9
let ZJFaceScoreListNearURL = "https://capi.douyucdn.cn/api/applivecompanion/getNearbyAnchorNew?aid=ios&cate1_id=0&cate2_id=0&cate3_id=0&client_sys=ios"


// 户外
// 福利推荐 https://apiv2.douyucdn.cn/live/anchorrecom/anchors?offset=0&client_sys=ios&cate2_id=124&limit=10
// 直播下的分类 https://capi.douyucdn.cn/api/v1/getThreeCate?client_sys=ios&tag_id=124
let ZJOutDoorsChildCateURL : String = "https://capi.douyucdn.cn/api/v1/getThreeCate?client_sys=ios&tag_id=124"

// 列表数据
// 全部 https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_124/0/20/ios?client_sys=ios
// 生活秀 https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/3_252/0/20/ios?client_sys=ios
// 节目秀 https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/3_776/0/20/ios?client_sys=ios
// .....

let ZJOutDoorsListURL : String = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/"


// 关注 可能感兴趣列表
// https://apiv2.douyucdn.cn/live/recom/getFwRecRoomList?client_sys=ios
let ZJFollowInterestURL = "https://apiv2.douyucdn.cn/live/recom/getFwRecRoomList?client_sys=ios"
// 超级主播排行榜
//https://apiv2.douyucdn.cn/live/recom/getFwRecAnchorList?client_sys=ios

let ZJFollowRankURL : String = "https://apiv2.douyucdn.cn/live/recom/getFwRecAnchorList?client_sys=ios"
//视频列表
//https://apiv2.douyucdn.cn/video/recom/getFwRecomVodList?client_sys=ios
let ZJFollowVideoURL : String = "https://apiv2.douyucdn.cn/video/recom/getFwRecomVodList?client_sys=ios"

// 请求视频数据 POST https://apiv2.douyucdn.cn/videonc/Stream/getAppPlayer?client_sys=ios
// 参数 列表获取   nt    0  vid    Kp1QM8LkQLVMk4bj



// 发现
// 热门视频列表
//https://apiv2.douyucdn.cn/video/home/getRecVideoList1?limit=4&client_sys=ios
let ZJDiscoverVideoListURL : String = "https://apiv2.douyucdn.cn/video/home/getRecVideoList1?limit=4&client_sys=ios"
// 赛事
//https://apiv2.douyucdn.cn/live/gameschedule/getContestList?gcid=0&first=1&gid=0&offset=0&client_sys=ios&limit=2
let ZJFindCompetitionURL : String = "https://apiv2.douyucdn.cn/live/gameschedule/getContestList?gcid=0&first=1&gid=0&offset=0&client_sys=ios&limit=2"

// 活动
//https://apiv2.douyucdn.cn/live/Home/getHomeActive?limit=15&client_sys=ios&offset=0
let ZJFindActivityURL : String = "https://apiv2.douyucdn.cn/live/Home/getHomeActive?limit=15&client_sys=ios&offset=0"

// 颜值
// https://capi.douyucdn.cn/api/applivecompanion/getNearbyAnchorNew?aid=ios&cate1_id=0&cate2_id=201&cate3_id=0&client_sys=ios&latitude=22.639390&limit=4&longitude=113.843980&offset=0&time=1534525413&auth=78b5edde09476a10f789ff8d56564d7a
let ZJDiscoverFaceListURL : String = "https://capi.douyucdn.cn/api/applivecompanion/getNearbyAnchorNew?aid=ios&cate1_id=0&cate2_id=201&cate3_id=0&client_sys=ios&latitude=22.639390&limit=4&longitude=113.843980&offset=0"

// 语音直播
// https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/1_18/0/4/ios?client_sys=ios
let ZJVoiceListURL : String = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/1_18/0/4/ios?client_sys=ios"

