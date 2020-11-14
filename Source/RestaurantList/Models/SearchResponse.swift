//
//  SearchResponse.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation

public struct SearchResponse: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case restaurants
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchResponse.CodingKeys.self)
        self.restaurants = try container.decode([Restaurant].self, forKey: SearchResponse.CodingKeys.restaurants)
    }

    public let restaurants: [Restaurant]
}
