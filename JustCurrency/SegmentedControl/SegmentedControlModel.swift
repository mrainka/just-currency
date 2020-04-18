//
//  SegmentedControlModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

final class SegmentedControlModel {

    let items: [SegmentedControlItemModel]

    var onSelected: ((String) -> Void)?

    var selectedItem: String? { items.first { $0.isSelected }?.title }

    init(items: [String], selectedItem: String) {
        let items = items.map { SegmentedControlItemModel($0, selected: $0 == selectedItem) }
        self.items = items
        items.forEach { $0.onClicked = { [unowned self] in self.clicked($0) } }
    }

    private func clicked(_ item: String) {
        items.forEach { $0.isSelected = $0.title == item }
        onSelected?(item)
    }
}
