
//
//  ZJNetworking.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/2.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum ZJMethod {
    case GET
    case POST
}

class ZJNetWorking {
    
    class func requestData(type : ZJMethod, URlString: String, parameters : [String : NSString]? = nil,  finishCallBack : @escaping (_ responseCall : Data)->()){
        
        let type = type == ZJMethod.GET ? HTTPMethod.get : HTTPMethod.post
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "charset":"utf-8",
            ]
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print("Method:\(type)请求\nURL: \(URlString)\n请求参数: \(String(describing: parameters))")
            if parameters != nil{
                print(parameters ?? String())
            }
            
            guard let result = response.result.value else {
                print(response.result.error ?? "错误❌")
                return
            }
            
            guard let dict = result as? [String : Any] else {
                return
            }
            guard let dataDict = dict["data"] as? [String : Any] else {
                return
                
            }
            
            
            let jsonData = try?JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
            
            print(dict)
            
            
            if jsonData != nil {
                finishCallBack(jsonData!)
            }
            
            
        }
        
    }
    
}


