//
//  SegmentedControl.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

final class SegmentedControl: UIView {

    private var items: [SegmentedControlItem] {
        stackView?.arrangedSubviews.compactMap { $0 as? SegmentedControlItem } ?? []
    }

    private(set) var model: SegmentedControlModel?

    private weak var stackView: UIStackView?

    // MARK: - Colors

    var borderColor = UIColor.label {
        didSet {
            items.forEach { $0.separatorColor = borderColor }
            updateBorderColor()
        }
    }

    // MARK: Item Background

    var normalItemBackgroundColor = UIColor.clear {
        didSet { items.forEach { $0.normalBackgroundColor = normalItemBackgroundColor } }
    }

    var selectedItemBackgroundColor = UIColor.label {
        didSet { items.forEach { $0.selectedBackgroundColor = selectedItemBackgroundColor } }
    }

    // MARK: Item Text

    var normalItemTextColor = UIColor.label {
        didSet { items.forEach { $0.normalTextColor = normalItemTextColor } }
    }

    var selectedItemTextColor = UIColor.systemBackground {
        didSet { items.forEach { $0.selectedTextColor = selectedItemTextColor } }
    }

    // MARK: -

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true

        layer.borderWidth = .pixel
        updateBorderColor()

        layer.cornerRadius = 6

        addStackView()
        configureLayoutOfStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addStackView() {
        let stackView = UIStackView(frame: .zero)
        stackView.distribution = .fillEqually
        addSubview(stackView)
        self.stackView = stackView
    }

    private func createItem() -> SegmentedControlItem {
        let item = SegmentedControlItem(frame: .zero)

        item.normalBackgroundColor = normalItemBackgroundColor
        item.selectedBackgroundColor = selectedItemBackgroundColor

        item.normalTextColor = normalItemTextColor
        item.selectedTextColor = selectedItemTextColor

        item.separatorColor = borderColor

        return item
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBorderColor()
        }
    }

    private func updateBorderColor() {
        layer.borderColor = borderColor.resolvedColor(with: traitCollection).cgColor
    }

    // MARK: - Configuring Stack View

    private func configureLayoutOfStackView() {
        guard let stackView = stackView else { return }

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([NSLayoutConstraint.Attribute.bottom, .left, .right, .top].map {
            .init(
                item: stackView,
                attribute: $0,
                relatedBy: .equal,
                toItem: stackView.superview,
                attribute: $0,
                multiplier: 1,
                constant: 0)
        })
    }

    private func configureStackView(with items: [SegmentedControlItemModel]) {
        guard let stackView = stackView else { return }

        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        items
            .map {
                let item = createItem()
                item.configure(with: $0)
                return item
            }
            .forEach { stackView.addArrangedSubview($0) }
    }

}

extension SegmentedControl: ConfigurableWithModel {

    func configure(with model: SegmentedControlModel) {
        self.model = model
        configureStackView(with: model.items)
    }
}
