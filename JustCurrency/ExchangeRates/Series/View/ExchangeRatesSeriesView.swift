//
//  ExchangeRatesSeriesView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class ExchangeRatesSeriesView: CustomView {

    private var disposeBag = DisposeBag()

    private(set) var model: ExchangeRatesSeriesViewModel?

    // MARK: - Subviews

    weak var activityIndicatorView: UIActivityIndicatorView?
    weak var refreshControl: UIRefreshControl?

    private weak var tableView: UITableView?
    private let tableViewDataSource = ExchangeRatesTableViewDataSource<ExchangeRatesSeriesViewModel>()

    private weak var dateRangePicker: DateRangePicker?

    // MARK: -

    override func configureLayout() {
        configureLayoutOfActivityIndicatorView()
        tableView?.snp.makeConstraints { $0.edges.equalToSuperview() }
        dateRangePicker?.snp.makeConstraints { $0.bottom.left.right.equalToSuperview() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateInsetsOfTableView()
    }

    @objc private func refresh() {
        model?.fetchRates()
    }

    private func updateInsetsOfTableView() {
        guard let tableView = tableView else { return }
        let dateRangePickerHeight = dateRangePicker?.bounds.height ?? 0
        tableView.contentInset.bottom = ExchangeRateCell.topInsetOfCustomView + dateRangePickerHeight
        tableView.verticalScrollIndicatorInsets.bottom = dateRangePickerHeight
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTableView()
        addActivityIndicatorView()
        addRefreshControl(to: tableView, action: #selector(refresh))
        addDateRangePicker()
    }

    private func addTableView() {
        let tableView = UITableView.createExchangeRates(dataSource: tableViewDataSource)
        addSubview(tableView)
        self.tableView = tableView
    }

    private func addDateRangePicker() {
        let picker = DateRangePicker(frame: .zero)
        picker.backgroundColor = .tertiarySystemBackground
        addSubview(picker)
        dateRangePicker = picker
    }
}

extension ExchangeRatesSeriesView: ActivityIndicableAndRefreshableView {}

extension ExchangeRatesSeriesView: ConfigurableWithModel {

    func configure(with model: ExchangeRatesSeriesViewModel) {
        disposeBag = .init()

        self.model = model

        configureActivityIndicatorAndRefreshControl(with: model, disposeBag: disposeBag)

        tableViewDataSource.configure(with: model)
        model.rates.subscribe(onNext: { [unowned self] _ in self.tableView?.reloadData() }).disposed(by: disposeBag)

        dateRangePicker?.configure(with: model.dateRangePicker)
    }
}
