//
//  MoviesScreenPresenter.swift
//  EverydayApp
//
//  Created by Danijel on 13/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation

class MovieScreenPresenter {
    
    weak var view: MovieScreenContract.View!
    
    var movie: Movie?
    
    required init(view: MovieScreenContract.View) {
        self.view = view
        
        view.setupYTPlayer()
        view.setupMovieView()
        
    }
    
}

extension MovieScreenPresenter: MovieScreenContract.Presenter {
    
    func fetchMovieTrailerData(movieID: String) {
        MoviesInteractor().getMovieData(movieID: movieID, url: Endpoint.MoviesApi.Features.MovieTrailer, classType: MovieTrailerData.self).then { movieTrailerData -> Void in
            if let results = movieTrailerData.results {
                if results.count == 0 { return }
                self.view.movieTrailerDataLoaded(key: results[0].key)
            }
        }.catch { error in }
    }
    
    func fetchMovieData(movieID: String) {
        MoviesInteractor().getMovieData(movieID: movieID, url: Endpoint.MoviesApi.Features.Movie, classType: Movie.self).then { movieData -> Void in
            self.view.movieLoaded(movieData: movieData)
        }.catch { error in }
    }
    
    func getPosterURL(path: String) -> URL {
        return APIService.buildEndpoint(url: path, api: APIService.API.moviesImageApi)!
    }
    
}
