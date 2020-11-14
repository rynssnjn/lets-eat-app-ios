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
            isLoading: false,
            selectedRestaurant: nil
        )
    }

    public var expandableDict: [String: Bool]

    public var restaurants: [Restaurant]

    public var currentPage: Int

    public var currentLocation: CLLocation?

    public var isLoading: Bool

    public var selectedRestaurant: Restaurant?

}

public final class RestaurantListVM: ViewModel<RestaurantListState> {
    private let service: RestaurantListService = RestaurantListService()

    public func getRestaurants() {
        self.set(isLoading: true)
        self.withState { [weak self] (state: RestaurantListState) -> Void in
            guard let s = self, let location = state.currentLocation else { return }
            s.service.getRestaurants(page: state.currentPage, coordinates: location.coordinate)
                .onSuccess { (response: SearchResponse) -> Void in
                    s.setState { (state: inout RestaurantListState) -> Void in
                        response.restaurants.forEach { (restaurant: Restaurant) -> Void in
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
                .onComplete { (_) -> Void in
                    s.set(isLoading: false)
                }
        }

    }

    public func set(isLoading: Bool) {
        self.setState { $0.isLoading = isLoading }
    }

    public func set(currentLocation: CLLocation) {
        self.setState { (state: inout RestaurantListState) -> Void in
            state.currentLocation = currentLocation
        }

        // Current Location is only define and set during first load of app. App needs current location
        // to get list of restaurants on first load.
        self.getRestaurants()
    }
}
