//
//  BaseResponse.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import CoreData
import ObjectMapper

class BaseResponse: NSObject, Mappable {
    
    var errorCode: Int?
    var success: Bool?
    
    override init() {}
    
    required init?(map: Map) {
        errorCode <- map["errorCode"]
        success <- map["success"]
    }
    
    //This function is where all variable mappings should occur.
    //It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        
    }
    
}
