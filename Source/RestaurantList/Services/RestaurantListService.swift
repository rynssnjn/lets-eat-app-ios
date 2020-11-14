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
import CoreLocation

public struct RestaurantListService: AbstractAPIService {

    public func getRestaurants(page: Int, coordinates: CLLocationCoordinate2D) -> Future<Restaurants, NetworkingError> {
        let request: Request = SearchRequest(page: page, coordinates: coordinates)

        return self.transform(request: request)
    }
}
