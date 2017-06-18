//
//  ApiModels.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import ObjectMapper

class PopularMoviesData: BaseResponse {
    
    var page: Int32?
    var results: [Movie]?
    var totalResults: Int32?
    var totalPages: Int32?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        page <- map["page"]
        results <- map["results"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
    }
    
}

class MovieTrailerData: BaseResponse {
    
    var id: Int32?
    var results: [MovieTrailer]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
        results <- map["results"]
    }

}

class Genres: BaseResponse {
    var id: Int32?
    var name: String?
    
    public override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}


