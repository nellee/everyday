//
//  MovieTrailer.swift
//  EverydayApp
//
//  Created by Danijel on 13/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieTrailer: BaseResponse {
    
    var id: Int32?
    var isoSix: String?
    var isoThree: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int32?
    var type: String?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
        isoSix <- map["iso_639_1"]
        isoThree <- map["iso_3166_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        size <- map["size"]
        type <- map["type"]
    }
    
}
