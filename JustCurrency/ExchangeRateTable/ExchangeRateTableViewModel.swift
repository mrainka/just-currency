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

    let rates = BehaviorRelay(value: [ExchangeRateViewModel]())
    let typeControl = SegmentedControlModel(items: ["A", "B", "C"], selectedItem: "A")

    private let repository: AnyRepository<[ExchangeRateTable]>
    private weak var repositoryAction: RepositoryAction?

    init(repository: AnyRepository<[ExchangeRateTable]>) {
        self.repository = repository

        typeControl.onSelected = { [unowned self] _ in
            self.showingActivity.accept(true)
            self.fetchRates()
        }
    }

    func fetchRates() {
        repositoryAction?.cancel()

        guard let type = typeControl.selectedItem else {
            hideActivity()
            return
        }

        if rates.value.isEmpty {
            showingActivity.accept(true)
        }

        repositoryAction = repository.query(ExchangeRateTableSpecification(type: type)) { [weak self] in
            guard let `self` = self else { return }

            self.hideActivity()

            switch $0 {
            case .failure:
                // TODO: Report an error to user.
                break
            case .success(let tables):
                guard let table = tables.first else { break }
                self.rates.accept(table.rates.map { .init($0, table: table) })
            }
        }
    }

    private func hideActivity() {
        showingActivity.accept(false)
        onEndRefreshingRequested?()
    }
}
