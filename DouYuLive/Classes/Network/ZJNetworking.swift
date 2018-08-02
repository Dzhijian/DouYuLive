
//
//  ZJNetworking.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/2.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import Alamofire
enum ZJMethod {
    case GET
    case POST
}

class ZJNetWorking {
    
    class func requestData(type : ZJMethod, URlString: String, parameters : [String : NSString]? = nil,  finishCallBack : @escaping (_ response : AnyObject)->()){
        
        let type = type == ZJMethod.GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default).response { (resResult) in
            
            guard let result = resResult.response else {

                return
            }
            
            finishCallBack(result as AnyObject)
        }
    }
}
