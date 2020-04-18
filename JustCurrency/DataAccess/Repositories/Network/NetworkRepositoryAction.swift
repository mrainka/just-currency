//
//  NetworkRepositoryAction.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import Alamofire

final class NetworkRepositoryAction {

    var dataRequest: DataRequest?
}

extension NetworkRepositoryAction: RepositoryAction {

    func cancel() {
        dataRequest?.cancel()
    }
}
