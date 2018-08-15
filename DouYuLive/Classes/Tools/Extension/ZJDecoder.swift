//
//  ZJDecoder.swift
//  DouYuLive
//
//  Created by 邓志坚 on 2018/8/7.
//  Copyright © 2018年 邓志坚. All rights reserved.
//

import UIKit

enum ZJError : Error {
    case message(String)
}

struct ZJDecoder {
    
    static func decode<T>(_ type: T.Type, data : Data) throws -> T where T: Decodable{

        guard let model = try? JSONDecoder().decode(type, from: data) else {
            print("转换模型失败")
            throw ZJError.message("转换模型失败")
        }
        return model
    }
    
    static func decode<T>(_ type: T.Type, param : [String:String]) throws -> T where T: Decodable{
        
        guard let jsonData = self.getJsonData(with: param) else {
            throw ZJError.message("转换 data 失败")
        }
        
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            throw ZJError.message("转换模型失败")
        }
        return model
    }
    
    static func getJsonData(with param : Any) -> Data?{
        if !JSONSerialization.isValidJSONObject(param){
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) else {
            return nil
        }
        return data
    }
    
}
