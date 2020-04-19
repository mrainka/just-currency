//
//  UITableViewFactory.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

extension UITableView {

    static func createExchangeRates<DataSourceType: ExchangeRatesContaining>(
        dataSource: ExchangeRatesTableViewDataSource<DataSourceType>,
        extraBottomInset: CGFloat = 0)
            -> UITableView
    {
        let tableView = UITableView(frame: .zero)
        tableView.contentInset.bottom = ExchangeRateCell.topInsetOfCustomView + extraBottomInset
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.register(ExchangeRateCell.self)
        return tableView
    }
}
