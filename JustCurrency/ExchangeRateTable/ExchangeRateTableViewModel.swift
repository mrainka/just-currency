//
//  ExchangeRateTableViewModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa

struct ExchangeRateTableViewModel {

    let rates = BehaviorRelay(value: [ExchangeRateViewModel]())
    let typeControl = SegmentedControlModel(items: ["A", "B", "C"], selectedItem: "A")
}
