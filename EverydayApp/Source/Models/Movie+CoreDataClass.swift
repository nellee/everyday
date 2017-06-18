//
//  Movie+CoreDataClass.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import CoreData
import ObjectMapper

@objc(Movie)
public class Movie: NSManagedObject, Mappable {
    
    var genres: [Genres]?
    var imdbID: String?
    
    public required init?(map: Map) {
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: ctx)
        super.init(entity: entity!, insertInto: ctx)
        
        mapping(map: map)
    }
    
    // MARK: - ObjectMapper Methods
    public func mapping(map: Map) {
        posterPath <- map["poster_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        genreIds <- map["genre_ids"]
        genres <- map["genres"]
        id <- map["id"]
        originalTitle <- map["original_title"]
        originalLanguage <- map["original_language"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        imdbID <- map["imdb_id"]
    
    }
    
}
