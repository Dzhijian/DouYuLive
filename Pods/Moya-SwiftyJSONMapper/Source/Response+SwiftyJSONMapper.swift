//
//  Observable+SwiftyJSONMapper.swift
//
//  Created by Antoine van der Lee on 26/01/16.
//  Copyright © 2016 Antoine van der Lee. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

public extension Response {

    /// Maps data received from the signal into an object which implements the ALSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: ALSwiftyJSONAble>(to type:T.Type) throws -> T {
        let jsonObject = try mapJSON()
        
        guard let mappedObject = T(jsonData: JSON(jsonObject)) else {
            throw MoyaError.jsonMapping(self)
        }
        
        return mappedObject
    }

    /// Maps data received from the signal into an array of objects which implement the ALSwiftyJSONAble protocol
    /// If the conversion fails, the signal errors.
    public func map<T: ALSwiftyJSONAble>(to type:[T.Type]) throws -> [T] {
        let jsonObject = try mapJSON()
        
        let mappedArray = JSON(jsonObject)
        let mappedObjectsArray = mappedArray.arrayValue.flatMap { T(jsonData: $0) }
        
        return mappedObjectsArray
    }

}

extension Response {
    
    @available(*, unavailable, renamed: "map(to:)")
    public func mapObject<T: ALSwiftyJSONAble>(type:T.Type) throws -> T {
        return try map(to: type)
    }
    
    @available(*, unavailable, renamed: "map(to:)")
    public func mapArray<T: ALSwiftyJSONAble>(type:T.Type) throws -> [T] {
        return try map(to: [type])
    }
}
