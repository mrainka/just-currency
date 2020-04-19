//
//  ExchangeRateTableRepositories.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct ExchangeRateTableRepositories {

    let series: AnyRepository<ExchangeRatesSeries>
    let tables: AnyRepository<[ExchangeRateTable]>
}
