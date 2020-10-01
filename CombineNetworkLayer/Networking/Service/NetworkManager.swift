//
//  NetworkManager.swift
//  ModernNetworkLayer
//
//  Created by Moises Hernandez Zamarripa on 30/09/20.
//  Copyright © 2020 cjapps. All rights reserved.
//

import Foundation

protocol NetworkManager {
    associatedtype RouterType: EndPointType
    var router: Router<RouterType> { get set }
    func handleNetwork(_ response: HTTPURLResponse) -> Result<Bool, NetworkError>
}

extension NetworkManager {
    
    func handleNetwork(_ response: HTTPURLResponse) -> Result<Bool, NetworkError> {
        switch response.statusCode {
        case 200...299: return .success(true)
        case 401...500: return .failure(NetworkError.authenticationError)
        case 501...599: return .failure(NetworkError.badRequest)
        case 600: return .failure(NetworkError.outdated)
        default: return .failure(NetworkError.failed)
        }
    }
}
