//
//  MoviesState.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import PromiseKit

class MoviesState {
    
    static let shared = MoviesState()
    
    private init() {
        
    }
    
    var favoritesMovies: Array<Any>?
    
    
    
}
