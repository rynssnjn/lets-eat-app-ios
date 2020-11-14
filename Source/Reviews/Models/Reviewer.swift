//
//  Reviewer.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation

public struct Reviewer: Decodable, Hashable {

    // MARK: CodingKeys
    public enum CodingKeys: String, CodingKey {
        case name
        case profileURL = "profile_url"
        case imageURL = "profile_image"
    }

    // MARK: Initalizer
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Reviewer.CodingKeys.self)
        self.name = try container.decode(String.self, forKey: Reviewer.CodingKeys.name)
        self.profileURL = try container.decode(String.self, forKey: Reviewer.CodingKeys.profileURL)
        self.imageURL = try container.decode(String.self, forKey: Reviewer.CodingKeys.imageURL)
    }

    // MARK: Stored Properties
    public let name: String
    public let profileURL: String
    public let imageURL: String
}
