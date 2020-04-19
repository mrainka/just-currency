//
//  DateRangePickerModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Foundation
import RxCocoa

final class DateRangePickerModel {

    private enum EditingDate { case start, end }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    private var editingDate: EditingDate?

    let isDatePickerHidden = BehaviorRelay(value: true)
    var onPickerDateRequested: (() -> Date?)?
    let pickerDate = BehaviorRelay(value: Date())

    private(set) var range: DateRange
    var onRangeChaged: ((DateRange) -> Void)?

    private(set) lazy var startDateTitle = BehaviorRelay(value: Self.dateFormatter.string(from: range.start))
    private(set) lazy var endDateTitle = BehaviorRelay(value: Self.dateFormatter.string(from: range.end))

    init(_ range: DateRange? = nil) {
        if let range = range {
            self.range = range
        } else {
            let currentDate = Date()
            self.range = .init(
                start: Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate,
                end: currentDate)
        }
    }

    func clicked(startDate: Bool) {
        storePickerDate()

        pickerDate.accept(startDate ? range.start : range.end)

        switch editingDate {
        case .none:
            isDatePickerHidden.accept(false)
            editingDate = startDate ? .start : .end
        case .some(.start):
            isDatePickerHidden.accept(startDate)
            editingDate = startDate ? nil : .end
        case .some(.end):
            isDatePickerHidden.accept(!startDate)
            editingDate = startDate ? .start : nil
        }
    }

    private func storePickerDate() {
        guard let editingDate = editingDate, let pickerDate = onPickerDateRequested?() else { return }

        let previousRange = range

        switch editingDate {
        case .start:
            range.start = pickerDate
            startDateTitle.accept(Self.dateFormatter.string(from: pickerDate))
        case .end:
            range.end = pickerDate
            endDateTitle.accept(Self.dateFormatter.string(from: pickerDate))
        }

        if range != previousRange {
            onRangeChaged?(range)
        }
    }
}
