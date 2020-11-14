//
//  Review.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import UIKit

public struct Review: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case review
    }

    // MARK: CodingKeys
    public enum ReviewKeys: String, CodingKey {
        case id
        case rating
        case comment = "review_text"
        case date = "review_time_friendly"
        case user
    }

    // MARK: Initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Review.CodingKeys.self)
        let review = try container.nestedContainer(
            keyedBy: Review.ReviewKeys.self,
            forKey: Review.CodingKeys.review
        )
        self.id = try review.decode(Int.self, forKey: ReviewKeys.id)
        self.rating = try review.decode(CGFloat.self, forKey: ReviewKeys.rating)
        self.comment = try review.decode(String.self, forKey: ReviewKeys.comment)
        self.date = try review.decode(String.self, forKey: ReviewKeys.date)
        self.reviewer = try review.decode(Reviewer.self, forKey: ReviewKeys.user)
    }

    // MARK: Stored Properties
    public let id: Int
    public let rating: CGFloat
    public let comment: String
    public let date: String
    public let reviewer: Reviewer
}
