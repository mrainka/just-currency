//
//  ExchangeRateTableViewController.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

final class ExchangeRateTableViewController: CustomViewController<ExchangeRateTableView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Exchange Rate Table"
        model?.fetchRates()
    }
}

extension ExchangeRateTableViewController: ConfigurableWithModel {}
