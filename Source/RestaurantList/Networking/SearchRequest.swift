//
//  SearchRequest.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import Astral

public struct SearchRequest: Request {

    // MARK: Initializer
    public init(page: Int) {
        self.page = page
    }

    // MARK: Stored Properties
    private let page: Int

    // MARK: Computed Properties
    public var configuration: RequestConfiguration {
        return BaseConfiguration()
    }

    public var method: HTTPMethod {
        return HTTPMethod.get
    }

    public var pathComponents: [String] {
        return [
            "search"
        ]
    }

    public var parameters: Parameters {
        return Parameters.dict([
            "count": 20,
            "lat": 14.559800,
            "lon": 121.014500,
            "sort": "real_distance",
            "start": self.page
        ])
    }

    public var headers: Set<Header> {
        return [
            Header(key: Header.Key.custom("user-key"), value: Header.Value.custom(Constants.userKey))
        ]
    }

    public let cachePolicy: URLRequest.CachePolicy? = nil
}
