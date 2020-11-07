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
}

extension AppDelegate: UIApplicationDelegate {
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool { //swiftlint:disable:this colon line_length
        self.parentCoordinator.start()
        return true
    }
}
