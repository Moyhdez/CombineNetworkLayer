//
//  MovieService.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation
import Combine

class MovieService: NetworkManager {
    
    static let enviroment: NetworkEnviroment = .production
    static let movieAPIKey = "7b692bb4f615f7a9c27b36097d5189e0"
    var router: Router<MovieEndPoint>
    var decoder: JSONDecoder
    
    init(router: Router<MovieEndPoint>, decoder: JSONDecoder) {
        self.router = router
        self.decoder = decoder
    }
    
    func getNewMovies(page: Int) -> AnyPublisher<MovieApiResponse, Error> {
        return router
            .run(.newMovies(page: 1))
//            .validateStatusCode({ (200..<300).contains($0) })
//            .mapJsonError(to: ApiErrorResponse.self, decoder: JSONDecoder())
            .mapJsonValue(to: MovieApiResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
