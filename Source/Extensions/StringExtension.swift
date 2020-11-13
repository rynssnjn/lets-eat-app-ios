//
//  StringExtension.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/13/20.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
