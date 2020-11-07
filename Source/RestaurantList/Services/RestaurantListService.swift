//
//  RestaurantListService.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import Astral
import BrightFutures
import BFAstral

public struct RestaurantListService: AbstractAPIService {

    public func getRestaurants(page: Int) -> Future<Restaurants, NetworkingError> {
        let request: Request = SearchRequest(page: page)

        return self.transform(request: request)
    }
}
