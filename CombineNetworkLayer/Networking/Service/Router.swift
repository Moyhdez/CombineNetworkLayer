//
//  Router.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation
import Combine

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    var session: URLSession
    var bodyEncoder: JSONEncoder
    
    init(session: URLSession, bodyEncoder: JSONEncoder) {
        self.session = session
        self.bodyEncoder = bodyEncoder
    }
    
    func run(_ route: EndPoint) -> AnyPublisher<DataTaskResult, URLError> {
        do {
            let request = try buildRequest(from: route)
            return self.session
                .dataTaskPublisher(for: request)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: URLError(URLError.badURL))
                .eraseToAnyPublisher()
        }
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
                self.add(additionalHeaders: additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
        } catch {
            throw error
        }
        
        return request
    }
    
    fileprivate func add(additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Encodable?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                request.httpBody = try bodyParameters.encode(with: self.bodyEncoder)
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                }
            }
        } catch {
            throw NetworkingError.unableToEncode
        }
    }
}
