//
//  ExchangeRateTableView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import SnapKit
import UIKit

final class ExchangeRateTableView: CustomView {

    private(set) var model: ExchangeRateTableViewModel?

    private weak var tableView: UITableView?
    private weak var typeControl: SegmentedControl?

    // MARK: -

    override func configureLayout() {
        tableView?.snp.makeConstraints { $0.edges.equalToSuperview() }
        typeControl?.snp.makeConstraints { $0.bottom.left.right.equalToSuperview().inset(8) }
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTableView()
        addTypeControl()
    }

    private func addTableView() {
        let tableView = UITableView(frame: .zero)
        addSubview(tableView)
        self.tableView = tableView
    }

    private func addTypeControl() {
        let control = SegmentedControl(frame: .zero)
        control.backgroundColor = .secondarySystemBackground
        addSubview(control)
        typeControl = control
    }
}

extension ExchangeRateTableView: ConfigurableWithModel {

    func configure(with model: ExchangeRateTableViewModel) {
        self.model = model
        typeControl?.configure(with: model.typeControl)
    }
}
