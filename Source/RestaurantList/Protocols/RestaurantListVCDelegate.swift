//
//  RestaurantListVCDelegate.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import CoreLocation

public protocol RestaurantListVCDelegate: class {

    func goToAcknowledgements()

    func openMaps(coordinates: CLLocationCoordinate2D)

}
