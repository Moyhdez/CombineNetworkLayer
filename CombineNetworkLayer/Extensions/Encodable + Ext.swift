//
//  Encodable + Ext.swift
//  CombineNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 01/10/20.
//

import Foundation

extension Encodable {
    func encode(with encoder: JSONEncoder) throws -> Data {
        return try encoder.encode(self)
    }
}
