//
//  MoviesScreenPresenter.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

struct MoviesConstants {
    
    //Constants
    static let tableViewCellHeight:CGFloat = 140
    
}

class MoviesListScreenPresenter {
    
    weak var view: MoviesListScreenContract.View!
    
    var popularMoviesItems: Array<Movie>?
    
    required init(view: MoviesListScreenContract.View) {
        self.view = view
    }
    
}

extension MoviesListScreenPresenter: MoviesListScreenContract.Presenter {
    
    func loadPopularMovies() {
        MoviesInteractor().getPopularMovies().then { popMoviesData -> Void in
            self.popularMoviesItems = popMoviesData.results
            self.view.setupTableView()
        }.catch { error in
            print(error)
        }
    }
    
    func getPopularMoviesRowCount() -> Int {
        return popularMoviesItems != nil ? popularMoviesItems!.count : 0
    }
    
    func getMovieWithIndex(index: Int) -> Movie {
        return popularMoviesItems![index]
    }
    
    func getPosterURL(path: String) -> URL {
        return APIService.buildEndpoint(url: path, api: APIService.API.moviesImageApi)!
    }
    
    func selectFilteredMovie(index: Int) {
        MovieScreenContract(movieID: String(popularMoviesItems![index].id)).push(navigationController: self.view.navigationController)
    }
    
}

