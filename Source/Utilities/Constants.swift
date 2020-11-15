//
//  Constants.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import UIKit

let NetworkQueue: DispatchQueue = DispatchQueue(
    label: "NetworkQueue",
    qos: DispatchQoS.utility,
    attributes: DispatchQueue.Attributes.concurrent
)

public enum APIKey {
    case search
    case review

    public var key: String {
        switch self {
            case .search:
                return "36cd11b60fd6a76958e11f22443bcd4e"
            case .review:
                return "4c3aca17ef64bdd1f703c1317dbc8ab7"
        }
    }
}

public enum Constants {

    // Height of the screen. Should be only use in views with UITableView that fits the screen.
    public static let contentHeight: CGFloat = UIScreen.main.bounds.height * 0.8

}

public let UIIdiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
