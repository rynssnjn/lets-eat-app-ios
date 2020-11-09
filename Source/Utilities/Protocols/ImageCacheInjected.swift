//
//  ImageCacheInjected.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/9/20.
//

import Foundation
import Kingfisher

public protocol ImageCacheInjected {
    var imageCacheManager: ImageCacheManager { get }
}

public extension ImageCacheInjected {
    var imageCacheManager: ImageCacheManager {
        return ImageCacheManager.shared
    }
}
