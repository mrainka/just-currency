//
//  ActivityIndicableAndRefreshableViewModel.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa

protocol ActivityIndicableAndRefreshableViewModel: class {

    var onEndRefreshingRequested: (() -> Void)? { get set }
    var showingActivity: BehaviorRelay<Bool> { get }
}

extension ActivityIndicableAndRefreshableViewModel {

    func hideActivityAndEndRefreshing() {
        showingActivity.accept(false)
        onEndRefreshingRequested?()
    }
}
