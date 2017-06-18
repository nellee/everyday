//
//  MoviesScreenContract.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class MoviesListScreenContract: BaseScreenContract<MoviesListViewController> {
    
    typealias View = MoviesListViewProtocol
    typealias Presenter = MoviesListPresenterProtocol
    
    override var storyboard: AppStoryboards {
        return .Movies
    }
    
}

protocol MoviesListViewProtocol: class, BaseViewProtocol {
    func setupTableView()
}

protocol MoviesListPresenterProtocol: class {
    func loadPopularMovies()
    func getPopularMoviesRowCount() -> Int
    func getMovieWithIndex(index: Int) -> Movie
    func getPosterURL(path: String) -> URL
    func selectFilteredMovie(index: Int)
}
