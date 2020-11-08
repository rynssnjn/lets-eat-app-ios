//
//  Ratings.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation
import UIKit
import RSJ

public struct Ratings: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case average = "aggregate_rating"
        case averageText = "rating_text"
        case votes
    }

    // MARK: Initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Ratings.CodingKeys.self)
        do {
            self.average = try container.decode(String.self, forKey: Ratings.CodingKeys.average)
        } catch DecodingError.typeMismatch {
            self.average = try container.decode(Int.self, forKey: Ratings.CodingKeys.average).rsj.asString
        }
        self.averageText = try container.decode(String.self, forKey: Ratings.CodingKeys.averageText)
        self.votes = try container.decode(Int.self, forKey: Ratings.CodingKeys.votes)
    }

    // MARK: Stored Properties
    public let average: String
    public let averageText: String
    public let votes: Int
}
