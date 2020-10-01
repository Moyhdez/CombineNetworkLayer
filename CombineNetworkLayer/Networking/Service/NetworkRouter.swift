//
//  NetworkRouter.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 29/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation
import Combine

typealias DataTaskResult = (data: Data, response: URLResponse)

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func run(_ route: EndPoint) throws -> AnyPublisher<DataTaskResult, URLError>
}
