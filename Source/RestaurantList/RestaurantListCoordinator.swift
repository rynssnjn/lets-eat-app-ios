//
//  RestaurantListCoordinator.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import RSJ
import UIKit
import CoreLocation

public final class RestaurantListCoordinator: AbstractCoordinator {

    // MARK: Initializer
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        super.init()
        self.navigationController.delegate = self
    }

    public override func start() {
        let vc: RestaurantListVC = RestaurantListVC(delegate: self)
        self.navigationController.viewControllers = [vc]
    }

    // MARK: Stored Properties
    private unowned let navigationController: UINavigationController
}

// MARK: RestaurantListVCDelegate Methods
extension RestaurantListCoordinator: RestaurantListVCDelegate {
    public func openMaps(coordinates: CLLocationCoordinate2D) {
        print("LATITUDE: \(coordinates.latitude)")
        print("LONGITUDE: \(coordinates.longitude)")
    }

    public func goToAcknowledgements() {
        let coordinator: AcknowledgementsCoordinator = AcknowledgementsCoordinator(
            delegate: self,
            navigationController: self.navigationController
        )

        coordinator.start()
        self.add(childCoordinator: coordinator)
    }
}

// MARK: AcknowledgementsCoordinatorDelegate Methods
extension RestaurantListCoordinator: AcknowledgementsCoordinatorDelegate {}

extension RestaurantListCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) { //swiftlint:disable:this line_length
        // TODO: Add deallocations
        self.navigationController.delegate = self
    }
}
