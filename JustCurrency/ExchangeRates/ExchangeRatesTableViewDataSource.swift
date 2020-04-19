//
//  ExchangeRatesTableViewDataSource.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Foundation
import UIKit

final class ExchangeRatesTableViewDataSource<ModelType: ExchangeRatesContaining>: NSObject, UITableViewDataSource {

    private(set) var model: ModelType?

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rate = model?.rates.value[indexPath.row] else { return .init() }
        let cell = tableView.dequeueReusableCell(with: rate, for: indexPath)
        (cell as? ExchangeRateCell)?.configure(with: rate)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.rates.value.count ?? 0
    }
}

extension ExchangeRatesTableViewDataSource: ConfigurableWithModel {

    func configure(with model: ModelType) {
        self.model = model
    }
}
