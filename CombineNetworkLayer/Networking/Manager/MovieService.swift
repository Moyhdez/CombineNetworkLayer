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
    var router: Router<MovieApi>
    
    init(router: Router<MovieApi>) {
        self.router = router
    }
    
    func getNewMovies(page: Int) throws -> AnyPublisher<MovieApiResponse, Error> {
        do {
            return try router.run(.newMovies(page: 1))
                .tryMap { data, response -> MovieApiResponse in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw NetworkError.failed
                    }
                    let result = self.handleNetwork(httpResponse)
                    switch result {
                    case .success:
                        do {
                            return try MovieApiResponse(data)
                        } catch {
                            throw NetworkError.unableToDecode
                        }
                    case .failure(let networkError):
                        throw networkError
                    }
                }
                .mapError({ (error) -> Error in
                    print(error.localizedDescription)
                    return error
                })
                .eraseToAnyPublisher()
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
