//
//  JSONParameterEncoder.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: BodyEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with body: Encodable, encoder: JSONEncoder) throws {
        do {
            urlRequest.httpBody = try body.encode(with: encoder)
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkingError.unableToEncode
        }
    }
}

extension Encodable {
    func encode(with encoder: JSONEncoder) throws -> Data {
        return try encoder.encode(self)
    }
}
