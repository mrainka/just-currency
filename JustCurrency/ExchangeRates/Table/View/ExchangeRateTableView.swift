//
//  ExchangeRateTableView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class ExchangeRateTableView: CustomView {

    private var disposeBag = DisposeBag()

    private static let insetOfTypeControl: CGFloat = 8

    private(set) var model: ExchangeRateTableViewModel?

    // MARK: - Subviews

    weak var activityIndicatorView: UIActivityIndicatorView?
    weak var refreshControl: UIRefreshControl?

    private weak var tableView: UITableView?
    private let tableViewDataSource = ExchangeRatesTableViewDataSource<ExchangeRateTableViewModel>()

    private weak var typeControl: SegmentedControl?

    // MARK: -

    override func configureLayout() {
        configureLayoutOfActivityIndicatorView()
        tableView?.snp.makeConstraints { $0.edges.equalToSuperview() }
        typeControl?.snp.makeConstraints { $0.bottom.left.right.equalToSuperview().inset(Self.insetOfTypeControl) }
    }

    @objc private func refresh() {
        model?.fetchRates()
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTableView()
        addActivityIndicatorView()
        addRefreshControl(to: tableView, action: #selector(refresh))
        addTypeControl()
    }

    private func addTableView() {
        let tableView = UITableView.createExchangeRates(
            dataSource: tableViewDataSource,
            extraBottomInset: SegmentedControl.intrinsicContentHeight + Self.insetOfTypeControl)
        addSubview(tableView)
        self.tableView = tableView
    }

    private func addTypeControl() {
        let control = SegmentedControl(frame: .zero)
        control.backgroundColor = .tertiarySystemBackground
        addSubview(control)
        typeControl = control
    }
}

extension ExchangeRateTableView: ActivityIndicableAndRefreshableView {}

extension ExchangeRateTableView: ConfigurableWithModel {

    func configure(with model: ExchangeRateTableViewModel) {
        disposeBag = .init()

        self.model = model

        configureActivityIndicatorAndRefreshControl(with: model, disposeBag: disposeBag)

        tableViewDataSource.configure(with: model)
        model.rates.subscribe(onNext: { [unowned self] _ in self.tableView?.reloadData() }).disposed(by: disposeBag)

        typeControl?.configure(with: model.typeControl)
    }
}
