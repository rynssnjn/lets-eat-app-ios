//
//  Category.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation

public enum Category {
    case ratings
    case menu
    case photos
    case time
    case type

    // MARK: Computed Properties
    public var title: String {
        switch self {
            case .ratings:
                return "Rating:"
            case .menu:
                return "Menu:"
            case .photos:
                return "Photos:"
            case .time:
                return "Schedule:"
            case .type:
                return "Type:"
        }
    }
}
