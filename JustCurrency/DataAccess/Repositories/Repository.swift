//
//  Repository.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

protocol Repository {

    associatedtype ItemType

    func query(
        _ specification: Specification,
        completion: @escaping (Result<ItemType, RepositoryActionError>) -> Void)
            -> RepositoryAction?
}
