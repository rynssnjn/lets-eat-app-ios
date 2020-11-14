//
//  RestaurantWebCoordinator.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/14/20.
//

import Foundation
import RSJ

public final class RestaurantWebCoordinator: AbstractCoordinator {

    // MARK: Initializer
    public init(navigationController: UINavigationController, url: String) {
        self.navigationController = navigationController
        self.url = url
        super.init()
    }

    // MARK: Stored Properties
    private unowned let navigationController: UINavigationController
    private let url: String

    // MARK: Instance Methods
    public override func start() {
        super.start()
        let vc: RestaurantWebVC = RestaurantWebVC(delegate: self, webURL: self.url)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: RestaurantWebVCDelegate Methods
extension RestaurantWebCoordinator: RestaurantWebVCDelegate {
    public func backButtonItemTapped() {
        self.navigationController.popViewController(animated: true)
    }
}
