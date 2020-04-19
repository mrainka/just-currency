//
//  ExchangeRateView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import SnapKit
import UIKit

final class ExchangeRateView: CustomView {

    private(set) var model: ExchangeRateViewModel?

    // MARK: - Subviews

    private weak var stackView: UIStackView?
    private weak var substackView: UIStackView?

    private weak var separator: UIView?

    // MARK: Labels

    private weak var averageRateLabel: Label?
    private weak var purchaseRateLabel: Label?
    private weak var sellingRateLabel: Label?

    private weak var codeLabel: Label?

    private weak var effectiveDateLabel: Label?
    private weak var tradingDateLabel: Label?

    private weak var nameLabel: Label?

    // MARK: -

    override func configureLayout() {
        stackView?.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }
        separator?.snp.makeConstraints { $0.width.equalTo(CGFloat.pixel) }
        codeLabel?.setContentHuggingPriority(.required, for: .horizontal)
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addStackView()

        addCodeLabel()

        addSeparator()

        addSubstackView()

        addNameLabel()

        averageRateLabel = addRateLabel()
        purchaseRateLabel = addRateLabel()
        sellingRateLabel = addRateLabel()

        effectiveDateLabel = addDateLabel()
        tradingDateLabel = addDateLabel()
    }

    private func addStackView() {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 8
        addSubview(stackView)
        self.stackView = stackView
    }

    private func addSubstackView() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        self.stackView?.addArrangedSubview(stackView)
        substackView = stackView
    }

    private func addSeparator() {
        let separator = UIView(frame: .zero)
        separator.backgroundColor = .opaqueSeparator
        stackView?.addArrangedSubview(separator)
        self.separator = separator
    }

    // MARK: Labels

    private func addCodeLabel() {
        let label = Label(frame: .zero)
        label.font = .boldSystemFont(ofSize: 21)
        stackView?.addArrangedSubview(label)
        codeLabel = label
    }

    private func addDateLabel() -> Label {
        let label = Label(frame: .zero)
        label.font = .systemFont(ofSize: 15)
        label.textColor = .tertiaryLabel
        substackView?.addArrangedSubview(label)
        return label
    }

    private func addNameLabel() {
        let label = Label(frame: .zero)
        label.font = .boldSystemFont(ofSize: 17)
        substackView?.addArrangedSubview(label)
        nameLabel = label
    }

    private func addRateLabel() -> Label {
        let label = Label(frame: .zero)
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        substackView?.addArrangedSubview(label)
        return label
    }
}

extension ExchangeRateView: ConfigurableWithModel {

    func configure(with model: ExchangeRateViewModel) {
        self.model = model

        averageRateLabel?.configure(with: model.averageRate)
        purchaseRateLabel?.configure(with: model.purchaseRate)
        sellingRateLabel?.configure(with: model.sellingRate)

        codeLabel?.configure(with: model.code)

        effectiveDateLabel?.configure(with: model.effectiveDate)
        tradingDateLabel?.configure(with: model.tradingDate)

        nameLabel?.configure(with: model.name)
    }
}
