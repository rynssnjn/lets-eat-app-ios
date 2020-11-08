//
//  UIImageViewExtensions.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(of imageURL: String) {
        if let url: URL = URL(string: imageURL) {
            let image = ImageResource(downloadURL: url, cacheKey: imageURL)
            self.kf.setImage(with: image)
        }
    }
}
