//
//  ReviewsCoordinator.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import RSJ
import Astral

public final class ReviewsCoordinator: AbstractCoordinator {

    // MARK: Delegate Properties
    private unowned let delegate: ReviewsCoordinatorDelegate

    // MARK: Initializer
    public init(delegate: ReviewsCoordinatorDelegate, restaurant: Restaurant, navigationController: UINavigationController) {
        self.delegate = delegate
        self.restaurant = restaurant
        self.navigationController = navigationController

        super.init()
    }

    // MARK: Stored Properties
    private unowned let navigationController: UINavigationController
    private let restaurant: Restaurant
    private let service: ReviewsService = ReviewsService()

    // MARK: Instance Methods
    public override func start() {
        super.start()
        let vc: ReviewsVC = ReviewsVC(delegate: self, restaurant: self.restaurant)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension ReviewsCoordinator: ReviewsVCDelegate {
    public func viewProfile(profile: String) {
        self.delegate.viewProfile(url: profile)
    }

    public func backButtonItemTapped() {
        self.navigationController.popViewController(animated: true)
    }
}
