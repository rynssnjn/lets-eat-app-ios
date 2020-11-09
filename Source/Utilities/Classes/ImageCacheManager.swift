//
//  ImageCacheManager.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/9/20.
//

import Foundation
import Kingfisher
import MapKit

public final class ImageCacheManager {

    // MARK: Initializer
    public init() {}

    // MARK: Stored Properties
    public static let shared: ImageCacheManager = ImageCacheManager()
    private let imageCache: ImageCache = ImageCache.default

    // MARK: Instance Methods
    public func save(image: UIImage, name: String) -> UIImage? {
        switch self.checkImageCache(name: name) {
            case true:
                return self.retrieve(name: name)

            case false:
                self.imageCache.store(
                    image,
                    original: image.pngData(),
                    forKey: name,
                    options: KingfisherParsedOptionsInfo(nil),
                    toDisk: false,
                    completionHandler: nil
                )
                return image
        }
    }

    public func retrieve(name: String) -> UIImage? {
        return self.imageCache.retrieveImageInMemoryCache(forKey: name)
    }

    public func checkImageCache(name: String) -> Bool {
        return self.imageCache.imageCachedType(forKey: name).cached
    }
}
