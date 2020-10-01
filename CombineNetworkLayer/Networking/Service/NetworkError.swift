//
//  NetworkError.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//


public enum NetworkError: Error {
    public typealias RawValue = String
    case parametersNil
    case encodingFailed
    case missingURL
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case custom(error: String?)
    
    var rawValue: String {
        switch self {
        case .parametersNil:
            return "Parameters were nil."
        case .encodingFailed:
            return "Parameter encoding failed."
        case .missingURL:
            return "URL is nil."
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad request."
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response"
        case .custom(let error):
            return error ?? "Please check your network connection."
        }
    }
    
    var localizedDescription: String {
        return rawValue
    }
}
