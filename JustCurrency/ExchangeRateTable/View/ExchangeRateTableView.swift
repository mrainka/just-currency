//
//  ExchangeRateTableView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class ExchangeRateTableView: CustomView {

    private weak var activityIndicatorView: UIActivityIndicatorView?
    private weak var refreshControl: UIRefreshControl?
    private weak var tableView: UITableView?
    private weak var typeControl: SegmentedControl?

    private var disposeBag = DisposeBag()

    private static let insetOfTypeControl: CGFloat = 8

    private(set) var model: ExchangeRateTableViewModel?

    // MARK: -

    override func configureLayout() {
        activityIndicatorView?.snp.makeConstraints { $0.center.equalToSuperview() }
        tableView?.snp.makeConstraints { $0.edges.equalToSuperview() }
        typeControl?.snp.makeConstraints { $0.bottom.left.right.equalToSuperview().inset(Self.insetOfTypeControl) }
    }

    @objc private func refresh() {
        model?.fetchRates()
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTableView(extraBottomInset: SegmentedControl.intrinsicContentHeight + Self.insetOfTypeControl)
        addActivityIndicatorView()
        addRefreshControl()
        addTypeControl()
    }

    private func addActivityIndicatorView() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
    }

    private func addRefreshControl() {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView?.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }

    private func addTableView(extraBottomInset: CGFloat) {
        let tableView = UITableView(frame: .zero)
        tableView.contentInset = .init(
            top: 0,
            left: 0,
            bottom: ExchangeRateCell.topInsetOfCustomView + extraBottomInset,
            right: 0)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ExchangeRateCell.self)
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

extension ExchangeRateTableView: ConfigurableWithModel {

    func configure(with model: ExchangeRateTableViewModel) {
        disposeBag = .init()

        self.model = model

        if let activityIndicatorView = activityIndicatorView {
            model.showingActivity.bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
        }

        model.onEndRefreshingRequested = { [weak self] in self?.refreshControl?.endRefreshing() }

        model.rates.subscribe(onNext: { [unowned self] _ in self.tableView?.reloadData() }).disposed(by: disposeBag)

        typeControl?.configure(with: model.typeControl)
    }
}

extension ExchangeRateTableView: UITableViewDataSource {

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
