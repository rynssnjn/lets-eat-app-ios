//
//  ReviewsRequest.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import Astral

public struct ReviewsRequest: Request {

    // MARK: Initializer
    public init(id: Int) {
        self.id = id
    }

    // MARK: Stored Properties
    private let id: Int
    public let cachePolicy: URLRequest.CachePolicy? = nil

    // MARK: Computed Properties
    public var configuration: RequestConfiguration {
        return BaseConfiguration()
    }

    public var method: HTTPMethod {
        return HTTPMethod.get
    }

    public var pathComponents: [String] {
        return [
            "reviews"
        ]
    }

    public var parameters: Parameters {
        return Parameters.dict([
            "res_id": self.id
        ])
    }

    public var headers: Set<Header> {
        return [
            Header(key: Header.Key.custom("user-key"), value: Header.Value.custom(APIKey.search.key))
        ]
    }
}
