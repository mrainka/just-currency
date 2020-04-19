//
//  ExchangeRatesSeries.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct ExchangeRatesSeries {

    private enum CodingKeys: String, CodingKey {

        case rates
    }

    let rates: [ExchangeRate]
}

extension ExchangeRatesSeries: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rates = (try? container.decode([ExchangeRate].self, forKey: .rates)) ?? []
    }
}
