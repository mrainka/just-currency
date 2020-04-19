//
//  CustomViewController.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

class CustomViewController<CustomViewType: UIView>: UIViewController {

    private(set) weak var customView: CustomViewType?
    var onCustomViewLoaded: ((CustomViewType) -> Void)?

    override func loadView() {
        let customView = CustomViewType(frame: .zero)
        view = customView
        self.customView = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customViewLoaded()
    }
}

extension CustomViewController: CustomViewContaining {}
