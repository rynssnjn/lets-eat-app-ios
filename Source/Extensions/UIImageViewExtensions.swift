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

    func loadMapImage(of location: Location) {
        let name: String = "\(location.latitude)\(location.longitude)imageCache"
        switch self.imageCacheManager.checkImageCache(name: name) {
            case true:
                self.image = self.imageCacheManager.retrieve(name: name)
            case false:
                guard
                    let latitude = location.latitude.rsj.asCGFloat,
                    let longitude = location.longitude.rsj.asCGFloat
                else {
                    return
                }
                let mapSnapshotOptions = MKMapSnapshotter.Options()
                let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(latitude),
                    longitude: CLLocationDegrees(longitude)
                )
                let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 0.0, longitudinalMeters: 0.0)
                mapSnapshotOptions.region = region

                let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)

                // takes snapshot of the map
                snapShotter.start { [weak self] (snapshot: MKMapSnapshotter.Snapshot?, _) -> Void in
                    guard let s = self else { return }
                    if let snap = snapshot {
                        let image = UIGraphicsImageRenderer(size: mapSnapshotOptions.size).image { _ in
                            snap.image.draw(at: .zero)

                            let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                            pinView.image = #imageLiteral(resourceName: "map-marker")
                            let pinImage = pinView.image

                            var point = snap.point(for: coordinates)
                            if s.bounds.contains(point) {
                                point.x -= pinView.bounds.width
                                point.y -= pinView.bounds.height
                                point.x += pinView.centerOffset.x
                                point.y += pinView.centerOffset.y
                                pinImage?.draw(at: point)
                            }
                        }
                        s.image = s.imageCacheManager.save(image: image, name: name)
                    } else {
                        s.image = #imageLiteral(resourceName: "placeholder")
                    }
                }
        }
    }
}
