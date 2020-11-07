//
//  LetsEatAppCoordinator.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import RSJ

public final class LetsEatAppCoordinator: AppCoordinator<UINavigationController> {

    // MARK: Initializer
    public override init(window: UIWindow, rootViewController: UINavigationController) {
        super.init(window: window, rootViewController: rootViewController)

        // MARK: Setup window property
        self.window.backgroundColor = UIColor.white
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()

        self.rootViewController.navigationBar.isTranslucent = false
    }

    // MARK: Instance Methods
    public override func start() {
        super.start()
        let coordinator: RestaurantListCoordinator = RestaurantListCoordinator(
            navigationController: self.rootViewController
        )

        coordinator.start()
        self.add(childCoordinator: coordinator)
    }
}
