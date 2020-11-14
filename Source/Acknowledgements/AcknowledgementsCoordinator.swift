//
//  AcknowledgementsCoordinator.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation
import RSJ

public final class AcknowledgementsCoordinator: AbstractCoordinator {

    // MARK: Initializer
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    // MARK: Stored Properties
    private unowned let navigationController: UINavigationController

    // MARK: Instance Methods
    public override func start() {
        super.start()
        if let acknowledgementFile = Bundle.main.path(forResource: "Acknowledgements", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: acknowledgementFile) {

            let acknowledgements: [Acknowledgement] = self.transformDictionary(dict)
            let vc: AcknowledgementsVC = AcknowledgementsVC(
                delegate: self,
                acknowledgements: acknowledgements
            )

            self.navigationController.pushViewController(vc, animated: true)
        }
    }

    private func transformDictionary(_ originalDictionary: NSDictionary) -> [Acknowledgement] {
        var acknowledgements: [Acknowledgement] = []
        if let dict = originalDictionary.object(forKey: "PreferenceSpecifiers") as? NSMutableArray {

            if let mutableTmp = dict.mutableCopy() as? NSMutableArray {
                mutableTmp.removeObject(at: 0)
                mutableTmp.removeLastObject()

                mutableTmp.forEach { (innerDict) -> Void in
                    if let dictionary = innerDict as? NSDictionary,
                        let tempTitle = dictionary.object(forKey: "Title") as? String,
                        let tempContent = dictionary.object(forKey: "FooterText") as? String {
                        acknowledgements.append(Acknowledgement(title: tempTitle, content: tempContent))
                    }
                }
            }
        }

        return acknowledgements
    }
}

// MARK: AcknowledgementsVCDelegate Methods
extension AcknowledgementsCoordinator: AcknowledgementsVCDelegate {
    public func backButtonItemTapped() {
        self.navigationController.popViewController(animated: true)
    }
}
