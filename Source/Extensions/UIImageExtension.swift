//
//  UIImageExtension.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/13/20.
//

import UIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat? = nil) -> UIImage? {
        if let newHeight = height {
            UIGraphicsBeginImageContext(CGSize(width: width, height: newHeight))
            self.draw(in: CGRect(x: 0.0, y: 0.0, width: width, height: newHeight))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return image
        } else {
            let scale = width / self.size.width
            let newHeight = self.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: width, height: newHeight))
            self.draw(in: CGRect(x: 0.0, y: 0.0, width: width, height: newHeight))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return image
        }
    }
}
