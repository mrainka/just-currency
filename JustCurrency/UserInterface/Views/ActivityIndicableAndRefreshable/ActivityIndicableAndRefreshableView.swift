//
//  ActivityIndicableAndRefreshableView.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 19/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

protocol ActivityIndicableAndRefreshableView: ConfigurableWithModel
    where Self: UIView, ModelType: ActivityIndicableAndRefreshableViewModel
{

    var activityIndicatorView: UIActivityIndicatorView? { get set }
    var refreshControl: UIRefreshControl? { get set }
}

extension ActivityIndicableAndRefreshableView {

    // MARK: - Configuring

    func configureActivityIndicatorAndRefreshControl(with model: ModelType, disposeBag: DisposeBag) {
        if let activityIndicatorView = activityIndicatorView {
            model.showingActivity.bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
        }

        model.onEndRefreshingRequested = { [weak self] in self?.refreshControl?.endRefreshing() }
    }

    func configureLayoutOfActivityIndicatorView() {
        activityIndicatorView?.snp.makeConstraints { $0.center.equalToSuperview() }
    }

    // MARK: - Adding the Subviews

    func addActivityIndicatorView() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
    }

    func addRefreshControl(to view: UIView?, action: Selector) {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: action, for: .valueChanged)
        view?.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }
}
