//
//  UIImageViewExtensions.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import UIKit
import Kingfisher
import MapKit

extension UIImageView: ImageCacheInjected {
    func loadImage(of imageURL: String) {
        if let url: URL = URL(string: imageURL) {
            let image = ImageResource(downloadURL: url, cacheKey: imageURL)
            self.kf.setImage(with: image)
        } else {
            self.image = #imageLiteral(resourceName: "placeholder")
        }
    }

    func loadMapImage(of restaurant: Restaurant) {
        let name: String = "\(restaurant.id)imageCache"
        switch self.imageCacheManager.checkImageCache(name: name) {
            case true:
                self.image = self.imageCacheManager.retrieve(name: name)
            case false:
                guard
                    let latitude = restaurant.location.latitude.rsj.asCGFloat,
                    let longitude = restaurant.location.longitude.rsj.asCGFloat
                else {
                    return
                }
                let mapSnapshotOptions = MKMapSnapshotter.Options()
                let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(latitude),
                    longitude: CLLocationDegrees(longitude)
                )
                let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapSnapshotOptions.region = region

                let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)

                // takes snapshot of the map
                snapShotter.start { [weak self] (snapshot: MKMapSnapshotter.Snapshot?, _) -> Void in
                    guard let s = self else { return }
                    if let snap = snapshot {
                        s.image = s.imageCacheManager.save(image: snap.image, name: name)
                    } else {
                        s.image = #imageLiteral(resourceName: "placeholder")
                    }
                }
        }
    }
}
