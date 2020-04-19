//
//  ExchangeRateTableViewModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa

final class ExchangeRateTableViewModel {

    var onEndRefreshingRequested: (() -> Void)?
    let showingActivity = BehaviorRelay(value: false)

    var onOpenSeriesRequested: ((ExchangeRatesSeriesViewModel) -> Void)?

    let rates = BehaviorRelay(value: [ExchangeRateViewModel]())
    let typeControl = SegmentedControlModel(items: ["A", "B", "C"], selectedItem: "A")

    private let repositories: ExchangeRateTableRepositories
    private weak var repositoryAction: RepositoryAction?

    init(repositories: ExchangeRateTableRepositories) {
        self.repositories = repositories

        typeControl.onSelected = { [unowned self] _ in
            self.showingActivity.accept(true)
            self.fetchRates()
        }
    }

    func fetchRates() {
        repositoryAction?.cancel()

        guard let type = typeControl.selectedItem else {
            hideActivityAndEndRefreshing()
            return
        }

        if rates.value.isEmpty {
            showingActivity.accept(true)
        }

        repositoryAction = repositories.tables.query(ExchangeRateTableSpecification(type: type)) { [weak self] in
            guard let `self` = self else { return }

            self.hideActivityAndEndRefreshing()

            switch $0 {
            case .failure:
                // TODO: Report an error to user.
                break
            case .success(let tables):
                guard let table = tables.first else { break }

                let rates: [ExchangeRateViewModel] = table.rates.map {
                    let rate = ExchangeRateViewModel($0, table: table)
                    rate.onClicked = { [weak self] in self?.openSeries(for: $0) }
                    return rate
                }

                self.rates.accept(rates)
            }
        }
    }

    private func openSeries(for rate: ExchangeRate) {
        guard let type = typeControl.selectedItem else { return }
        onOpenSeriesRequested?(.init(tableType: type, rate: rate, repository: repositories.series))
    }
}

extension ExchangeRateTableViewModel: ActivityIndicableAndRefreshableViewModel {}

extension ExchangeRateTableViewModel: ExchangeRatesContaining {}
