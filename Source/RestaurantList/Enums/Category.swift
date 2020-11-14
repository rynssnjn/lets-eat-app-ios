//
//  Category.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation

public enum Category {
    case time
    case type

    // MARK: Computed Properties
    public var title: String {
        switch self {
            case .time:
                return "schedule"
            case .type:
                return "type"
        }
    }
}
