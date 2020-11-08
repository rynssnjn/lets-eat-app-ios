//
//  AcknowledgementsVM.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation
import Cyanic

public struct AcknowledgementsState: ExpandableState {

    public static var `default`: AcknowledgementsState {
        return AcknowledgementsState(
            expandableDict: [:],
            acknowledgements: []
        )
    }

    public var expandableDict: [String: Bool]

    public var acknowledgements: [Acknowledgement]
}

public final class AcknowledmentsVM: ViewModel<AcknowledgementsState> {}
