//
//  MoviesScreenPresenter.swift
//  EverydayApp
//
//  Created by Danijel on 12/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation

class MoviesScreenPresenter {
    
    weak var view: MoviesScreenContract.View!
    
    var filteredData: [Movie]?
    
    required init(view: MoviesScreenContract.View) {
        self.view = view
        
        self.view.setupSearchBar()
        self.view.setupSearchBarTableView()
    }
    
}

extension MoviesScreenPresenter: MoviesScreenContract.Presenter {

    func showPopularMoviesInMoviesListController() {
        MoviesListScreenContract().push(navigationController: self.view.navigationController)
    }
    
    func filterDataWithSearchText(searchText: String) {
        MoviesInteractor().getFilteredMovies(searchText: searchText).then { moviesData -> Void in
            self.filteredData = moviesData.results
            self.view.filteredDataLoaded()
            }.catch { error in
                print(error)
        }
    }
    
    func getFilteredDataCount() -> Int {
        return filteredData != nil ? filteredData!.count : 0
    }
    
    func getFilteredMovie(index: Int) -> Movie {
        return filteredData![index]
    }
    
    func clearFilteredData() {
        filteredData = nil
        self.view.filteredDataLoaded()
    }
    
    func selectFilteredMovie(index: Int) {
        guard let safeID = filteredData?[index].id else {
            return
        }
        MovieScreenContract(movieID: String(describing: safeID)).push(navigationController: self.view.navigationController)
    }
    
}
