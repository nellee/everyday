//
//  APIService.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON

//MARK: - Endpoints
struct Endpoint {
    
    struct MoviesApi {
        //Api
        static let ApiKey = "?api_key=2c9ba26c23cbcb41b48fb482afb01a22"
        static let BaseApiURL = "https://api.themoviedb.org/3"
        static let BaseImageApiURL = "https://image.tmdb.org/t/p/w500"
        
        struct Features {
            
            static let PopularMovies = "/movie/popular"
            static let FilteredMovies = "/search/movie"
            static let NowPlayingMovies = "/movie/now_playing"
            static let MovieTrailer = "/movie/%@/videos"
            static let Movie = "/movie/%@"
        }
        
    }
    
    struct FootballApi {
    
    }
}

class APIService {
    
    enum API {
        case moviesApi
        case moviesImageApi
        case footballApi
    }
    
    static func buildEndpoint(url: String, api: API) -> URL? {
        let urlString = getBaseUrl(api: api) + url + getApiKey(api: api)
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    static func buildEndpoint(url: String, appendStringForFormat: String, api: API) -> URL? {
        let urlString = getBaseUrl(api: api) + String(format: url, appendStringForFormat) + getApiKey(api: api)
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    private static func getBaseUrl(api: API) -> String {
        switch api {
        case .moviesApi:
            return Endpoint.MoviesApi.BaseApiURL
        case .moviesImageApi:
            return Endpoint.MoviesApi.BaseImageApiURL
        case .footballApi:
            return "TODO"
        }
    }
    
    private static func getApiKey(api: API) -> String {
        switch api {
        case .moviesApi, .moviesImageApi:
            return Endpoint.MoviesApi.ApiKey
        case .footballApi:
            return "TODO"
        }
    }
}
