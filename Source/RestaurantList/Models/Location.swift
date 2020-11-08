//
//  Location.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation

public struct Location: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case address
        case latitude
        case longitude
    }

    // MARK: Initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Location.CodingKeys.self)
        self.address = try container.decode(String.self, forKey: Location.CodingKeys.address)
        self.latitude = try container.decode(String.self, forKey: Location.CodingKeys.latitude)
        self.longitude = try container.decode(String.self, forKey: Location.CodingKeys.longitude)
    }

    // MARK: Stored Properties
    public let address: String
    public let latitude: String
    public let longitude: String
}
