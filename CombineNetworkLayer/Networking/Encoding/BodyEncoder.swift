//
//  BodyEncoder.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation

public protocol BodyEncoder {
    static func encode(urlRequest: inout URLRequest, with body: Encodable, encoder: JSONEncoder) throws
}
