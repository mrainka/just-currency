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

extension ExchangeRateTableViewController: ConfigurableWithModel {

    func configure(with model: ExchangeRateTableViewModel) {
        model.onOpenSeriesRequested = { [weak self] in
            let view = ExchangeRatesSeriesViewController()
            view.configure(with: $0)
            self?.navigationController?.pushViewController(view, animated: true)
        }

        configureCustomView(with: model)
    }
}
