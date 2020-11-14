//
//  ReviewsService.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import Astral
import BrightFutures
import BFAstral
import CoreLocation

public struct ReviewsService: AbstractAPIService {

    public func getReviews(id: Int) -> Future<Critics, NetworkingError> {
        let request: Request = ReviewsRequest(id: id)

        return self.transform(request: request)
    }

}
