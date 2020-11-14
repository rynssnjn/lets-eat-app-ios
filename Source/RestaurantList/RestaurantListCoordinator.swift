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
import MapKit

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
    public func goToReviews(restaurant: Restaurant) {
        let coordinator: ReviewsCoordinator = ReviewsCoordinator(
            delegate: self,
            restaurant: restaurant,
            navigationController: self.navigationController
        )

        coordinator.start()
        self.add(childCoordinator: coordinator)
    }

    public func gotToWeb(url: String) {
        let coordinator: RestaurantWebCoordinator = RestaurantWebCoordinator(
            navigationController: self.navigationController,
            url: url
        )

        coordinator.start()
        self.add(childCoordinator: coordinator)
    }

    public func openMaps(restaurant: Restaurant) {
        guard
            let latitude = restaurant.location.latitude.rsj.asCGFloat,
            let longitude = restaurant.location.longitude.rsj.asCGFloat
        else {
            return
        }

        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(latitude),
            longitude: CLLocationDegrees(longitude)
        )

        let mapItem: MKMapItem = MKMapItem(
            placemark: MKPlacemark(
                coordinate: coordinates,
                addressDictionary: nil
            )
        )

        mapItem.name = restaurant.name
        mapItem.phoneNumber = restaurant.phoneNumber
        mapItem.openInMaps(launchOptions: nil)
    }

    public func goToAcknowledgements() {
        let coordinator: AcknowledgementsCoordinator = AcknowledgementsCoordinator(
            navigationController: self.navigationController
        )

        coordinator.start()
        self.add(childCoordinator: coordinator)
    }
}

// MARK: ReviewsCoordinatorDelegate Methods
extension RestaurantListCoordinator: ReviewsCoordinatorDelegate {
    public func viewProfile(url: String) {
        self.gotToWeb(url: url)
    }
}

// MARK: UINavigationControllerDelegate Methods
extension RestaurantListCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(
                forKey: UITransitionContextViewControllerKey.from
            ),
            !navigationController.viewControllers.contains(fromViewController),
            fromViewController is AcknowledgementsVC ||
            fromViewController is RestaurantWebVC ||
            fromViewController is ReviewsVC
        else {
            return
        }

        guard
            let coordinator = self.childCoordinators.first(where: {
                $0 is AcknowledgementsCoordinator || $0 is RestaurantWebCoordinator ||
                $0 is ReviewsCoordinator
            })
        else {
            return
        }

        switch (fromViewController is RestaurantWebVC, coordinator is ReviewsCoordinator) {
            case (true, true):
                guard
                    let webCoordinator = self.childCoordinators.first(where: { $0 is RestaurantWebCoordinator })
                else {
                    return
                }
                self.remove(childCoordinator: webCoordinator)
            default:
                self.remove(childCoordinator: coordinator)
        }

        self.navigationController.delegate = self
    }
}
