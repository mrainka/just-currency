//
//  Label.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

final class Label: UILabel {

    private(set) var model: LabelModel?
}

extension Label: ConfigurableWithModel {

    func configure(with model: LabelModel) {
        self.model = model

        isHidden = model.isHidden
        text = model.text
    }
}

