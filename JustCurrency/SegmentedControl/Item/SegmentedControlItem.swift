//
//  SegmentedControlItem.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

final class SegmentedControlItem: UIButton {

    private(set) var model: SegmentedControlItemModel?

    private weak var separator: UIView?

    // MARK: - Colors

    var normalBackgroundColor: UIColor? { didSet { updateBackgroundAndTextColor() } }
    var selectedBackgroundColor: UIColor? { didSet { updateBackgroundAndTextColor() } }

    var normalTextColor: UIColor? { didSet { updateBackgroundAndTextColor() } }
    var selectedTextColor: UIColor? { didSet { updateBackgroundAndTextColor() } }

    var separatorColor: UIColor? {
        get { separator?.backgroundColor }
        set { separator?.backgroundColor = newValue }
    }

    // MARK: -

    override init(frame: CGRect) {
        super.init(frame: frame)

        addTarget(self, action: #selector(clicked), for: .touchUpInside)

        contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)

        addSeparator()
        configureLayoutOfSeparator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSeparator() {
        let separator = UIView(frame: .zero)
        addSubview(separator)
        self.separator = separator
    }

    @objc private func clicked() {
        model?.clicked()
    }

    private func configureLayoutOfSeparator() {
        guard let separator = separator else { return }

        separator.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [separator.widthAnchor.constraint(equalToConstant: .pixel)]

        constraints += [NSLayoutConstraint.Attribute.bottom, .right, .top].map {
            .init(
                item: separator,
                attribute: $0,
                relatedBy: .equal,
                toItem: separator.superview,
                attribute: $0,
                multiplier: 1,
                constant: 0)
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func updateBackgroundAndTextColor(selected: Bool? = nil) {
        let isSelected = selected ?? model?.isSelected ?? false

        backgroundColor = isSelected ? selectedBackgroundColor : normalBackgroundColor
        setTitleColor(isSelected ? selectedTextColor : normalTextColor, for: .normal)
    }
}

extension SegmentedControlItem: ConfigurableWithModel {

    func configure(with model: SegmentedControlItemModel) {
        self.model = model

        setTitle(model.title, for: .normal)

        updateBackgroundAndTextColor(selected: model.isSelected)
        model.onSelectedChanged = { [weak self] in self?.updateBackgroundAndTextColor(selected: $0) }
    }
}
