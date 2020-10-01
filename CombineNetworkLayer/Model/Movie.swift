//
//  Movie.swift
//  CombineNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 30/09/20.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let posterPath: String
    let backdropPath: String
    let title: String
    let releaseDate: Date
    let overview: String
}
