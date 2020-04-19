//
//  CustomView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSubviews()
        configureLayout()
    }

    /// If you subclass CustomView directly, your implementation of this method does not need to call `super`.
    func addSubviews() {}

    /// If you subclass CustomView directly, your implementation of this method does not need to call `super`.
    func configureLayout() {}
}
