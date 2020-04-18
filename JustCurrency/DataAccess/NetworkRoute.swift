//
//  NetworkRoute.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Alamofire

enum NetworkRoute {

    case exchangeRateTable(type: String)

    private var path: String {
        switch self {
        case .exchangeRateTable(let type):
            return "/tables/" + type
        }
    }
}

extension NetworkRoute: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        try .init(url: "https://api.nbp.pl/api/exchangerates".asURL().appendingPathComponent(path))
    }
}
