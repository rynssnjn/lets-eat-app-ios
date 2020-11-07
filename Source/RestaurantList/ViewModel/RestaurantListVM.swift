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

public struct RestaurantListState: ExpandableState {
    public static var `default`: RestaurantListState {
        return RestaurantListState(
            expandableDict: [:],
            restaurants: [],
            currentPage: 0
        )
    }

    public var expandableDict: [String: Bool]

    public var restaurants: [Restaurant]

    public var currentPage: Int
}

public final class RestaurantListVM: ViewModel<RestaurantListState> {
    private let service: RestaurantListService = RestaurantListService()

    public func getRestaurants(page: Int) -> Future<Restaurants, NetworkingError> {
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
    }

}
