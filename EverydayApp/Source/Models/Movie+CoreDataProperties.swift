//
//  Movie+CoreDataProperties.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var posterPath: String?
    @NSManaged public var adult: Bool
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var genreIds: [Int32]?
    @NSManaged public var id: Int32
    @NSManaged public var originalTitle: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var title: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var popularity: Double
    @NSManaged public var voteCount: Int32
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double

}
