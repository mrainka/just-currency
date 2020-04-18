//
//  ExchangeRateTable.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Foundation

struct ExchangeRateTable {

    private enum CodingKeys: String, CodingKey {

        case effectiveDate
        case tradingDate

        case rates
    }

    let effectiveDate: Date
    let tradingDate: Date?

    let rates: [ExchangeRate]
}

extension ExchangeRateTable: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        effectiveDate = try container.decode(Date.self, forKey: .effectiveDate)
        tradingDate = try? container.decode(Date.self, forKey: .tradingDate)

        rates = (try? container.decode([ExchangeRate].self, forKey: .rates)) ?? []
    }
}
