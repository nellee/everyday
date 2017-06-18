//
//  MoviesScreenContract.swift
//  EverydayApp
//
//  Created by Danijel on 12/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class MoviesScreenContract: BaseScreenContract<MoviesViewController> {
    
    typealias View = MoviesViewProtocol
    typealias Presenter = MoviesPresenterProtocol
    
    override var storyboard: AppStoryboards {
        return .Movies
    }
    
}

protocol MoviesViewProtocol: class, BaseViewProtocol {
    func setupSearchBar()
    func setupSearchBarTableView()
    func filteredDataLoaded()
}

protocol MoviesPresenterProtocol: class {
    func showPopularMoviesInMoviesListController()
    func filterDataWithSearchText(searchText: String)
    func getFilteredDataCount() -> Int
    func getFilteredMovie(index: Int) -> Movie
    func clearFilteredData()
    func selectFilteredMovie(index: Int)
}
