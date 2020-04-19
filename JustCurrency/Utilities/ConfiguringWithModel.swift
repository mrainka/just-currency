//
//  ConfiguringWithModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

protocol ConfigurableWithModel {

    associatedtype ModelType

    var model: ModelType? { get }

    func configure(with model: ModelType)
}

extension ConfigurableWithModel where Self: CustomViewContaining, CustomViewType: ConfigurableWithModel {

    var model: CustomViewType.ModelType? { customView?.model }

    func configure(with model: CustomViewType.ModelType) {
        if let customView = customView {
            customView.configure(with: model)
        } else {
            onCustomViewLoaded = { $0.configure(with: model) }
        }
    }
}
