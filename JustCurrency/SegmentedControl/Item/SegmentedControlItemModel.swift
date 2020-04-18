//
//  SegmentedControlItemModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

final class SegmentedControlItemModel {

    var isSelected: Bool { didSet { onSelectedChanged?(isSelected) } }
    var onSelectedChanged: ((Bool) -> Void)?

    var onClicked: ((String) -> Void)?

    let title: String

    init(_ title: String, selected: Bool) {
        isSelected = selected
        self.title = title
    }

    func clicked() {
        onClicked?(title)
    }
}
