//
//  AnyRepository.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

struct AnyRepository<ItemType> {

    private let onQueried:
        (Specification, @escaping (Result<ItemType, RepositoryActionError>) -> Void) -> RepositoryAction?

    init<RepositoryType: Repository>(_ repository: RepositoryType) where RepositoryType.ItemType == ItemType {
        onQueried = repository.query
    }
}

extension AnyRepository: Repository {

    func query(
        _ specification: Specification,
        completion: @escaping (Result<ItemType, RepositoryActionError>) -> Void)
            -> RepositoryAction?
    {
        onQueried(specification, completion)
    }
}
