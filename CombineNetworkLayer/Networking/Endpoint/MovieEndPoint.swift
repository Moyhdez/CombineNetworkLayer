//
//  MovieEndPoint.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation

enum NetworkEnviroment {
    case qa
    case production
    case staging
}

enum MovieEndPoint {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
}

extension MovieEndPoint: EndPointType {
    
    var environmentBaseURL : String {
        switch MovieService.enviroment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            let urlParameters: Parameters = [
                "page": page,
                "api_key": MovieService.movieAPIKey
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: urlParameters)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
