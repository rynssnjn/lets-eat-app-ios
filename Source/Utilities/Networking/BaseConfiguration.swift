//
//  ZomatoAPIConfiguration.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import Astral

public struct BaseConfiguration: RequestConfiguration {

    public var scheme: URLScheme = URLScheme.https

    public var host: String {
        return "developers.zomato.com"
    }

    public var basePathComponents: [String] {
        return [
            "api",
            "v2.1"
        ]
    }

    public let baseHeaders: Set<Header> = [
        Header(key: Header.Key.contentType, value: Header.Value.mediaType(MediaType.applicationJSON))
    ]
}
