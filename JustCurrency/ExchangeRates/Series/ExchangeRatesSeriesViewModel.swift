//
//  ExchangeRatesSeriesViewModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa

final class ExchangeRatesSeriesViewModel {

    var onEndRefreshingRequested: (() -> Void)?
    let showingActivity = BehaviorRelay(value: false)

    let rates = BehaviorRelay(value: [ExchangeRateViewModel]())
    let dateRangePicker = DateRangePickerModel()

    private let repository: AnyRepository<ExchangeRatesSeries>
    private weak var repositoryAction: RepositoryAction?

    private let tableType: String
    private let currencyCode: String?

    let title: String?

    init(tableType: String, rate: ExchangeRate, repository: AnyRepository<ExchangeRatesSeries>) {
        self.repository = repository

        self.tableType = tableType
        currencyCode = rate.code

        title = rate.name

        dateRangePicker.onRangeChaged = { [unowned self] _ in
            self.showingActivity.accept(true)
            self.fetchRates()
        }
    }

    func fetchRates() {
        repositoryAction?.cancel()

        guard let currencyCode = currencyCode else {
            hideActivityAndEndRefreshing()
            return
        }

        if rates.value.isEmpty {
            showingActivity.accept(true)
        }

        let specification = ExchangeRatesSeriesSpecification(
            tableType: tableType,
            currencyCode: currencyCode,
            range: dateRangePicker.range)

        repositoryAction = repository.query(specification) { [weak self] in
            guard let `self` = self else { return }

            self.hideActivityAndEndRefreshing()

            switch $0 {
            case .failure:
                // TODO: Report an error to user.
                break
            case .success(let series):
                self.rates.accept(series.rates.map { .init($0) })
            }
        }
    }
}

extension ExchangeRatesSeriesViewModel: ActivityIndicableAndRefreshableViewModel {}

extension ExchangeRatesSeriesViewModel: ExchangeRatesContaining {}
