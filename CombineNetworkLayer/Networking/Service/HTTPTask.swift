//
//  HTTPTask.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Encodable?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Encodable?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
