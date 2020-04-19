//
//  ExchangeRatesSeriesViewController.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

final class ExchangeRatesSeriesViewController: CustomViewController<ExchangeRatesSeriesView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        model?.fetchRates()
    }
}

extension ExchangeRatesSeriesViewController: ConfigurableWithModel {

    func configure(with model: ExchangeRatesSeriesViewModel) {
        title = model.title
        configureCustomView(with: model)
    }
}
