//
//  ExchangeRatesSeriesSpecification.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct ExchangeRatesSeriesSpecification {

    let networkRoute: NetworkRoute

    init(tableType: String, currencyCode: String, range: DateRange) {
        networkRoute = .exchangeRatesSeries(tableType: tableType, currencyCode: currencyCode, range: range)
    }
}

extension ExchangeRatesSeriesSpecification: NetworkSpecification {}
