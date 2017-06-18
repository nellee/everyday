//
//  MoviesInteractor.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import ObjectMapper

class MoviesInteractor {
    
    func getPopularMovies() -> Promise<PopularMoviesData> {
        return Promise { fulfill, reject in
            
            if let url = APIService.buildEndpoint(url: Endpoint.MoviesApi.Features.PopularMovies, api: .moviesApi)?.absoluteString {
                AFWrapper.request(url: url,
                    classType: PopularMoviesData.self,
                    success: { popularMoviesData -> Void in
                        fulfill(popularMoviesData)
                }) {
                    (error) -> Void in
                    reject(error)
                }
            }
        }
    }
    
    func getFilteredMovies(searchText: String) -> Promise<PopularMoviesData> {
        return Promise { fulfill, reject in
            
            if let url = APIService.buildEndpoint(url: Endpoint.MoviesApi.Features.FilteredMovies, api: .moviesApi)?.absoluteString {
                let parameters: Parameters = ["query": searchText]
                AFWrapper.request(url: url,
                                  classType: PopularMoviesData.self,
                                  parameters: parameters,
                                  success: { filteredMovies -> Void in
                                    fulfill(filteredMovies)
                }) { (error) -> Void in
                    print(error)
                }
            }
            
        }
    }
    
    func getMovieData<T: Mappable>(movieID: String, url: String, classType: T.Type) -> Promise<T> {
        return Promise { fulfill, reject in
            
            if let url = APIService.buildEndpoint(url: url, appendStringForFormat: movieID, api: .moviesApi) {
                AFWrapper.request(url: url.absoluteString,
                                  classType: T.self,
                                  success: { movieData -> Void in
                                    fulfill(movieData)
                }) { error -> Void in
                    print(error)
                }
            }
            
        }
    }
    
    

}
