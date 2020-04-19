//
//  ExchangeRateCell.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import SnapKit
import UIKit

final class ExchangeRateCell: UITableViewCell {

    private static let borderColorOfCustomView = UIColor.label
    static let topInsetOfCustomView: CGFloat = 8

    private(set) weak var customView: ExchangeRateView?
    var onCustomViewLoaded: ((ExchangeRateView) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        addCustomView()
        configureLayoutOfCustomView()
        customViewLoaded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addCustomView() {
        let customView = ExchangeRateView(frame: .zero)
        customView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
        customView.backgroundColor = .secondarySystemBackground
        customView.clipsToBounds = true
        customView.layer.borderWidth = .pixel
        customView.layer.cornerRadius = 6
        contentView.addSubview(customView)
        self.customView = customView
        updateBorderColorOfCustomView()
    }

    @objc private func clicked() {
        model?.clicked()
    }

    private func configureLayoutOfCustomView() {
        customView?.snp.makeConstraints {
            let inset = UIEdgeInsets(top: Self.topInsetOfCustomView, left: 8, bottom: 0, right: 8)
            $0.edges.equalToSuperview().inset(inset)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBorderColorOfCustomView()
        }
    }

    private func updateBorderColorOfCustomView() {
        customView?.layer.borderColor = Self.borderColorOfCustomView.resolvedColor(with: traitCollection).cgColor
    }
}

extension ExchangeRateCell: ConfigurableWithModel {}

extension ExchangeRateCell: CustomViewContaining {}
