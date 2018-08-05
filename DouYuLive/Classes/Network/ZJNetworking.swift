
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
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "charset":"utf-8",
            "User-Device":"NjQxMmY2NmM4M2EzMjJlOTBmYTMzMDdkMDAwMDE1MjF8NC42MTA=",
            "Cookie":"acf_did=6412f66c83a322e90fa3307d00001521",
            "time":"1533369765",
            "Accept-Encoding":"br, gzip, deflate",
            "auth":"e01ef9d1b2e033e1a54a4806b502534b"
        ]
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print("Method:\(type)请求\nURL: \(URlString)\n请求参数: \(String(describing: parameters))")
            if parameters != nil{
                print(parameters ?? String())
            }

            if let json = response.result.value {
                print("请求成功 🍏:\n\(json)")
            }
        }
    
 
    }
}
