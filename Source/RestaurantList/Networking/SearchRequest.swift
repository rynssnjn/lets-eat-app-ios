//
//  SearchRequest.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import Astral
import CoreLocation

public struct SearchRequest: Request {

    // MARK: Initializer
    public init(page: Int, coordinates: CLLocationCoordinate2D) {
        self.page = page
        self.coordinates = coordinates
    }

    // MARK: Stored Properties
    private let page: Int
    private let coordinates: CLLocationCoordinate2D
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
            "search"
        ]
    }

    public var parameters: Parameters {
        return Parameters.dict([
            "count": 20,
            "lat": self.coordinates.latitude,
            "lon": self.coordinates.longitude,
            "sort": "real_distance",
            "start": self.page
        ])
    }

    public var headers: Set<Header> {
        return [
            Header(key: Header.Key.custom("user-key"), value: Header.Value.custom(APIKey.search.key))
        ]
    }
}
