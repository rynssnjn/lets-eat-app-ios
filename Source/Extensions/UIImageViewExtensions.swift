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
                let options: MKMapSnapshotter.Options = MKMapSnapshotter.Options()
                let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(latitude),
                    longitude: CLLocationDegrees(longitude)
                )
                let region: MKCoordinateRegion = MKCoordinateRegion(
                    center: coordinates,
                    latitudinalMeters: 0.0,
                    longitudinalMeters: 0.0
                )
                options.region = region

                let shotter: MKMapSnapshotter = MKMapSnapshotter(options: options)

                // takes snapshot of the map
                shotter.start { [weak self] (snapshot: MKMapSnapshotter.Snapshot?, _) -> Void in
                    guard let s = self else { return }
                    if let snapshot = snapshot {
                        let image: UIImage = UIGraphicsImageRenderer(size: options.size)
                            .image { _ in
                                snapshot.image.draw(at: .zero)
                                let point: CGPoint = snapshot.point(for: coordinates)
                                let pinView: MKPinAnnotationView = MKPinAnnotationView(
                                    annotation: nil,
                                    reuseIdentifier: nil
                                )
                                pinView.image = #imageLiteral(resourceName: "map-marker")
                                if let pinImage = pinView.image {
                                    let pinPoint = CGPoint(
                                        x: point.x - (pinImage.size.width / 2.0),
                                        y: point.y - pinImage.size.height
                                    )

                                    pinImage.draw(at: pinPoint)
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
