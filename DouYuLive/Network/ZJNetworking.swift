
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
    
    class func requestData(type : ZJMethod, URlString: String, parameters : [String : Any]? = nil,  finishCallBack : @escaping (_ responseCall : Data)->()){
        
        let type = type == ZJMethod.GET ? HTTPMethod.get : HTTPMethod.post
        // 配置 HTTPHeaders
        let headers: HTTPHeaders = [
            "charset":"utf-8",
            "Cookie" : "acf_did=6412f66c83a322e90fa3307d00001521",
            "User-Device": "NjQxMmY2NmM4M2EzMjJlOTBmYTMzMDdkMDAwMDE1MjF8NS4wMDA=",
            "time" : getTimeStamp(),
            "auth" : "f390ebfa09d1dbe6765e91f82ee62b34",
            "aid"  : "ios",
            "User-Agent" : "ios/5.000 (ios 12.1; ; iPhone 6 (A1549/A1586))",
            "Accept-Encoding" : "br, gzip, deflate",
            "Content-Type" : "application/x-www-form-urlencoded",
        ]
        
        
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            // 处理 cookie
//            let headerFields = response.response?.allHeaderFields as! [String: String]
//            let url = response.request?.url
//            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
//            var cookieArray = [ [HTTPCookiePropertyKey : Any ] ]()
//            for cookie in cookies {
//                cookieArray.append(cookie.properties!)
//            }
//            if !(UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN) != nil){
//                // 保存 cookie
//                UserDefaults.standard.set(cookieArray, forKey: ZJ_DOUYU_TOKEN)
//            }else{
////                print("token\(String(describing: UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN)))")
//            }
            print("\n====================== ZJNetWorking ===============================")
            print("Method:\(type)请求\nURL: \(URlString)\n请求参数parameters:")
//            print(parameters as! [String : String])
            
            if parameters != nil{
                print(response.request?.url ?? "url")
                print(parameters ?? String())
            }
            
            // 判断是否错误
            guard let result = response.result.value else {
                print(response.result.error ?? "请求错误❌")
                return
            }
            print("返回报文response:")
            // 打印请求返回的报文
//           print(result)
            debugPrint(result)
            guard let dict = result as? [String : Any] else {
                return
            }
            
            // 返回字典类型 Data
            if let dataDict = dict["data"] as? [String : Any] {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                if jsonData != nil {
                    finishCallBack(jsonData!)
                    return
                }
            }
            
            // 返回数组类型Data
            if ((dict["data"] as? [Any]) != nil) {
                let arrData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                if arrData != nil {
                    finishCallBack(arrData!)
                }
            }
            
            // 直接返回报文数据
            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            if jsonData != nil {
                finishCallBack(jsonData!)
                return
            }
        }
        
    }
    
}


