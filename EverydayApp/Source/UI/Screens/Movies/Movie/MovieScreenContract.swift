//
//  MoviesScreenContract.swift
//  EverydayApp
//
//  Created by Danijel on 13/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class MovieScreenContract: BaseScreenContract<MovieViewController> {
    
    typealias View = MovieViewProtocol
    typealias Presenter = MoviePresenterProtocol
    
    var movieID: String!
    
    init(movieID: String) {
        self.movieID = movieID
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override var storyboard: AppStoryboards {
        return .Movies
    }
    
    override func configureViewController(viewController: UIViewController?) {
        if let vc = viewController as? MovieViewController {
            vc.movieID = self.movieID
        }
    }
    
}

protocol MovieViewProtocol: class, BaseViewProtocol {
    func setupYTPlayer()
    func setupMovieView()
    func movieLoaded(movieData: Movie)
    func movieTrailerDataLoaded(key: String?)
}

protocol MoviePresenterProtocol: class {
    func fetchMovieTrailerData(movieID: String)
    func fetchMovieData(movieID: String)
    func getPosterURL(path: String) -> URL
}
