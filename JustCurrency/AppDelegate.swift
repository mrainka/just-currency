//
//  AppDelegate.swift
//  JustCurrency
//
//  Created by Marcin Rainka on 18/04/2020.
//  Copyright © 2020 Marcin Rainka. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {

    var window: UIWindow?

    private func configureWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = Self.createRootView()
        window.makeKeyAndVisible()
        self.window = window
    }

    private static func createRootView() -> UINavigationController {
        let view = ExchangeRateTableViewController()
        view.configure(with: .init())
        let navigatedView = UINavigationController(rootViewController: view)
        navigatedView.navigationBar.isTranslucent = false
        return navigatedView
    }
}

extension AppDelegate: UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
            -> Bool
    {
        configureWindow()
        return true
    }
}
