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

public enum Constants {

    public static let userKey = "36cd11b60fd6a76958e11f22443bcd4e"

}

public let UIIdiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
