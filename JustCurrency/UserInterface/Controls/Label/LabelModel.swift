//
//  LabelModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct LabelModel {

    let isHidden: Bool
    let text: String?

    init(_ text: String?, hidden: Bool? = nil) {
        isHidden = hidden ?? text?.isEmpty ?? true
        self.text = text
    }
}
