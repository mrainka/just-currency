//
//  NetworkRepository.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Alamofire
import Foundation

private extension Error {

    var isCancelledURLError: Bool {
        let error: Error

        if let afError = self as? AFError {
            if case .explicitlyCancelled = afError {
                return true
            }

            error = afError.underlyingError ?? self
        } else {
            error = self
        }

        let code = (error as NSError).code

        return code == NSURLErrorCancelled || code == 102
    }
}

struct NetworkRepository<ItemType> where ItemType: Decodable {

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}

extension NetworkRepository: Repository {

    func query(
        _ specification: Specification,
        completion: @escaping (Result<ItemType, RepositoryActionError>) -> Void)
            -> RepositoryAction?
    {
        guard let specification = specification as? NetworkSpecification else {
            completion(.failure(.other))
            return nil
        }

        var action: NetworkRepositoryAction? = .init()

        action?.dataRequest = AF
            .request(specification.networkRoute)
            .responseDecodable(of: ItemType.self, decoder: decoder) {
                defer { action = nil }

                let error = $0.error

                guard error == nil, let data = $0.value else {
                    completion(.failure(error?.isCancelledURLError ?? false ? .cancelled : .other))
                    return
                }

                completion(.success(data))
            }

        return action
    }
}
