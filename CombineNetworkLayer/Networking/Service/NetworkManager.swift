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
    var decoder: JSONDecoder { get set }
}
