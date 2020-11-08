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
        case location
        case thumbnail = "thumb"
        case featuredImage = "featured_image"
        case photos = "photos_url"
        case menu = "menu_url"
        case ratings = "user_rating"
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
        self.location = try restaurant.decode(Location.self, forKey: RestaurantKeys.location)
        self.thumbnailURL = try restaurant.decode(String.self, forKey: RestaurantKeys.thumbnail)
        self.featuredImage = try restaurant.decode(String.self, forKey: RestaurantKeys.featuredImage)
        self.photosURL = try restaurant.decode(String.self, forKey: RestaurantKeys.photos)
        self.menuURL = try restaurant.decode(String.self, forKey: RestaurantKeys.menu)
        self.ratings = try restaurant.decode(Ratings.self, forKey: RestaurantKeys.ratings)
    }

    // MARK: Stored Properties
    public let id: String
    public let name: String
    public let location: Location
    public let thumbnailURL: String
    public let featuredImage: String
    public let photosURL: String
    public let menuURL: String
    public let ratings: Ratings
}
