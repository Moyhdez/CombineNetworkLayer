//
//  JSONDecoder + Ext.swift
//  CombineNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 01/10/20.
//

import Foundation

extension JSONDecoder {
    static func movieDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
