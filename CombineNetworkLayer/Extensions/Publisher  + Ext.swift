//
//  Publisher  + Ext.swift
//  CombineNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 01/10/20.
//

import Foundation
import Combine

enum ValidationError: Error {
    case error(Error)
    case jsonError(Data)
}

extension Publisher where Output == DataTaskResult {
    
    func validateStatusCode(_ isValid: @escaping (Int) -> Bool) -> AnyPublisher<Output, ValidationError> {
        return validateResponse { (data, response) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            return isValid(statusCode)
        }
    }

    fileprivate func validateResponse(_ isValid: @escaping (DataTaskResult) -> Bool) -> AnyPublisher<Output, ValidationError> {
        return self
            .mapError { .error($0) }
            .flatMap { (result) -> AnyPublisher<DataTaskResult, ValidationError> in
                let (data, _) = result
                if isValid(result) {
                    return Just(result)
                        .setFailureType(to: ValidationError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(outputType: Output.self, failure: .jsonError(data))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == ValidationError {
    func mapJsonError<E: Error & Decodable>(to errorType: E.Type, decoder: JSONDecoder) -> AnyPublisher<Output, Error> {
        return self
            .catch { (error: ValidationError) -> AnyPublisher<Output, Error> in
                switch error {
                case .error(let e):
                    return Fail(outputType: Output.self, failure: e)
                        .eraseToAnyPublisher()
                case .jsonError(let data):
                    return Just(data)
                        .decode(type: E.self, decoder: decoder)
                        .flatMap { Fail(outputType: Output.self, failure: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

extension Publisher where Output == DataTaskResult {
    func mapJsonValue<Output: Decodable>(to outputType: Output.Type, decoder: JSONDecoder) -> AnyPublisher<Output, Error> {
        return self
            .map(\.data)
            .decode(type: outputType, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
