//
//  ExchangeRate.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct ExchangeRate {

    private enum CodingKeys: String, CodingKey {

        case averageRate = "mid"
        case purchaseRate = "bid"
        case sellingRate = "ask"

        case code

        case name = "currency"
    }

    let averageRate: Double?
    let purchaseRate: Double?
    let sellingRate: Double?

    let code: String

    let name: String
}

extension ExchangeRate: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        averageRate = try? container.decode(Double.self, forKey: .averageRate)
        purchaseRate = try? container.decode(Double.self, forKey: .purchaseRate)
        sellingRate = try? container.decode(Double.self, forKey: .sellingRate)

        code = try container.decode(String.self, forKey: .code)

        name = try container.decode(String.self, forKey: .name)
    }
}
