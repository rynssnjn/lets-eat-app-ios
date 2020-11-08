//
//  RestaurantListVM.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import UIKit
import Cyanic
import RxSwift
import Astral
import BrightFutures
import CoreLocation

public struct RestaurantListState: ExpandableState {
    public static var `default`: RestaurantListState {
        return RestaurantListState(
            expandableDict: [:],
            restaurants: [],
            currentPage: 0,
            currentLocation: nil,
            isLoading: false
        )
    }

    public var expandableDict: [String: Bool]

    public var restaurants: [Restaurant]

    public var currentPage: Int

    public var currentLocation: CLLocation?

    public var isLoading: Bool
}

public final class RestaurantListVM: ViewModel<RestaurantListState> {
    private let service: RestaurantListService = RestaurantListService()

    public func getRestaurants(page: Int) {
        self.set(isLoading: true)
        self.service.getRestaurants(page: page)
            .onSuccess { [weak self] (restaurants: Restaurants) -> Void in
                guard let s = self else { return }
                s.setState { (state: inout RestaurantListState) -> Void in
                    restaurants.restaurants.forEach { (restaurant: Restaurant) -> Void in
                        if state.restaurants.contains(restaurant) == false {
                            state.restaurants.append(restaurant)
                        }
                    }
                    state.currentPage += 1
                }
            }
            .onFailure { (error: NetworkingError) -> Void in
                print(error.localizedDescription)
            }
            .onComplete { [weak self] (_) -> Void in
                guard let s = self else { return }
                s.set(isLoading: false)
            }
    }

    public func set(isLoading: Bool) {
        self.setState { $0.isLoading = isLoading }
    }

}
