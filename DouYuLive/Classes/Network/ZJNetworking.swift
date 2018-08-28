
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
    
    class func requestData(type : ZJMethod, URlString: String, parameters : [String : String]? = nil,  finishCallBack : @escaping (_ responseCall : Data)->()){
        
        let type = type == ZJMethod.GET ? HTTPMethod.get : HTTPMethod.post
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "charset":"utf-8",
            ]
   
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let headerFields = response.response?.allHeaderFields as! [String: String]
            let url = response.request?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
            var cookieArray = [ [HTTPCookiePropertyKey : Any ] ]()
            for cookie in cookies {
                cookieArray.append(cookie.properties!)
            }
            if !(UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN) != nil){
                
                UserDefaults.standard.set(cookieArray, forKey: ZJ_DOUYU_TOKEN)
            }else{
                print("token\(String(describing: UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN)))")
            }
            print("Method:\(type)请求\nURL: \(URlString)\n请求参数: \(String(describing: parameters))")
            if parameters != nil{
                print(response.request?.url ?? "url")
                
                print(parameters ?? String())
            }
            
            guard let result = response.result.value else {
                print(response.result.error ?? "错误❌")
                return
            }
            
            guard let dict = result as? [String : Any] else {
                return
            }
            
            if let dataDict = dict["data"] as? [String : Any] {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
//                print(dict)
                if jsonData != nil {
                    finishCallBack(jsonData!)
                    return
                }
            }
            
            if ((dict["data"] as? [Any]) != nil) {
            
                let arrData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//                print(dict)
                if arrData != nil {
                    finishCallBack(arrData!)
                }
            }
        
        }
        
    }
    
}


