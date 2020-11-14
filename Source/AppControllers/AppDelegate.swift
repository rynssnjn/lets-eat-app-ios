//
//  AppDelegate.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import UIKit

@main
class AppDelegate: UIResponder {
    // MARK: Stored Properties
    public var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private let rootViewController: UINavigationController = UINavigationController()
    private lazy var parentCoordinator: LetsEatAppCoordinator = LetsEatAppCoordinator(
       window: self.window!,
       rootViewController: self.rootViewController
    )

    private func setupAppearance() {
        if let window = self.window, #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        }
    }
}

extension AppDelegate: UIApplicationDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { //swiftlint:disable:this colon
        self.setupAppearance()
        self.parentCoordinator.start()
        return true
    }
}
