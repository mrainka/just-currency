//
//  ExchangeRateTableSpecification.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct ExchangeRateTableSpecification {

    let networkRoute: NetworkRoute

    init(type: String) {
        networkRoute = .exchangeRateTable(type: type)
    }
}

extension ExchangeRateTableSpecification: NetworkSpecification {}
