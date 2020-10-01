//
//  MovieApiResponse.swift
//  CombineNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 30/09/20.
//

import Foundation

struct MovieApiResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
}
