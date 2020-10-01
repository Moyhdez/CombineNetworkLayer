//
//  JSONParameterEncoder.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: BodyEncoder {
    public static func encode(urlRequest: inout URLRequest, with body: Encodable) throws {
        do {
            urlRequest.httpBody = try body.encoded()
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
