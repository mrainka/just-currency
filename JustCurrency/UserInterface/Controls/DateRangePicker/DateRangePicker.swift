//
//  DateRangePicker.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class DateRangePicker: CustomView {

    private var disposeBag = DisposeBag()

    private(set) var model: DateRangePickerModel?

    // MARK: - Subviews

    private weak var stackView: UIStackView?
    private weak var substackView: UIStackView?

    private weak var datePicker: UIDatePicker?

    private weak var startDateButton: UIButton?
    private weak var endDateButton: UIButton?

    private weak var buttonsSeparatorLabel: Label?

    private weak var separator: UIView?

    // MARK: -

    @objc private func clicked(_ button: UIButton) {
        model?.clicked(startDate: button === startDateButton)
    }

    override func configureLayout() {
        stackView?.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }

        separator?.snp.makeConstraints {
            $0.height.equalTo(CGFloat.pixel)
            $0.left.right.top.equalToSuperview()
        }
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addStackView()

        addDatePicker()

        addSubstackView()
        substackView?.addArrangedSubview(.init(frame: .zero))
        startDateButton = addButton()
        addButtonsSeparatorLabel()
        endDateButton = addButton()
        substackView?.addArrangedSubview(.init(frame: .zero))

        addSeparator()
    }

    private func addStackView() {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        addSubview(stackView)
        self.stackView = stackView
    }

    private func addSubstackView() {
        let stackView = UIStackView(frame: .zero)
        stackView.distribution = .equalCentering
        self.stackView?.addArrangedSubview(stackView)
        substackView = stackView
    }

    private func addButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        button.setTitleColor(.link, for: .normal)
        substackView?.addArrangedSubview(button)
        return button
    }

    private func addButtonsSeparatorLabel() {
        let label = Label(frame: .zero)
        label.text = "-"
        substackView?.addArrangedSubview(label)
        buttonsSeparatorLabel = label
    }

    private func addDatePicker() {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        stackView?.addArrangedSubview(picker)
        datePicker = picker
    }

    private func addSeparator() {
        let separator = UIView(frame: .zero)
        separator.backgroundColor = .opaqueSeparator
        addSubview(separator)
        self.separator = separator
    }
}

extension DateRangePicker: ConfigurableWithModel {

    func configure(with model: DateRangePickerModel) {
        disposeBag = .init()

        self.model = model

        if let datePicker = datePicker {
            model.isDatePickerHidden.bind(to: datePicker.rx.isHidden).disposed(by: disposeBag)
            model.pickerDate.bind(to: datePicker.rx.date).disposed(by: disposeBag)
        }

        model.onPickerDateRequested = { [weak self] in self?.datePicker?.date }

        if let startDateButton = startDateButton {
            model.startDateTitle.bind(to: startDateButton.rx.title(for: .normal)).disposed(by: disposeBag)
        }

        if let endDateButton = endDateButton {
            model.endDateTitle.bind(to: endDateButton.rx.title(for: .normal)).disposed(by: disposeBag)
        }
    }
}
