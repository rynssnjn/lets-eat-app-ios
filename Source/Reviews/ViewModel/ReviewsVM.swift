//
//  ReviewsVM.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import UIKit
import Cyanic
import RxSwift
import Astral
import BrightFutures

public struct ReviewsState: State {
    public static var `default`: ReviewsState {
        return ReviewsState(
            restaurant: nil,
            reviews: [],
            isLoading: false
        )
    }

    public var restaurant: Restaurant?

    public var reviews: [Review]

    public var isLoading: Bool
}

public final class ReviewsVM: ViewModel<ReviewsState> {
    public let service: ReviewsService = ReviewsService()

    public func getReviews() {
        self.set(isLoading: true)
        self.withState { [weak self] (state: ReviewsState) -> Void in
            guard
                let s = self,
                let restaurant = state.restaurant,
                let id = restaurant.id.rsj.asInt
            else {
                return
            }

            s.service.getReviews(id: id)
                .onSuccess { (critics: Critics) -> Void in
                    s.setState { (state: inout ReviewsState) -> Void in
                        state.reviews = critics.reviews
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
}
