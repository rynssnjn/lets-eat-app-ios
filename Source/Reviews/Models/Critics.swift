//
//  Critics.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation

public struct Critics: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case reviews = "user_reviews"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Critics.CodingKeys.self)
        self.reviews = try container.decode([Review].self, forKey: Critics.CodingKeys.reviews)
    }

    public let reviews: [Review]
}
