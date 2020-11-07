//
//  Restaurant.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation

public struct Restaurant: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case restaurant
    }

    public enum RestaurantKeys: String, CodingKey {
        case id
        case name
    }

    // MARK: Initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Restaurant.CodingKeys.self)
        let restaurant = try container.nestedContainer(
            keyedBy: Restaurant.RestaurantKeys.self,
            forKey: Restaurant.CodingKeys.restaurant
        )
        self.id = try restaurant.decode(String.self, forKey: RestaurantKeys.id)
        self.name = try restaurant.decode(String.self, forKey: RestaurantKeys.name)

    }

    // MARK: Stored Properties
    public let id: String
    public let name: String
}
