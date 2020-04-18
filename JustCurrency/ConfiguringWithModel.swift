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
