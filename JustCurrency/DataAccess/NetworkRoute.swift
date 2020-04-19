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
    case exchangeRatesSeries(tableType: String, currencyCode: String, range: DateRange)

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    private var path: String {
        switch self {
        case .exchangeRateTable(let type):
            return "/tables/" + type
        case .exchangeRatesSeries(let tableType, let currencyCode, range: let range):
            let startDate = Self.dateFormatter.string(from: range.start)
            let endDate = Self.dateFormatter.string(from: range.end)
            return "/rates/\(tableType)/\(currencyCode)/\(startDate)/\(endDate)"
        }
    }
}

extension NetworkRoute: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        try .init(url: "https://api.nbp.pl/api/exchangerates".asURL().appendingPathComponent(path))
    }
}
