//
//  ImageHeaderComponent.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = ImageHeaderComponent
public protocol ImageHeaderComponentType: StaticHeightComponent {

    // sourcery: defaultValue = "100.0"
    var height: CGFloat { get set }

    // sourcery: defaultValue = """"
    var imageURL: String { get set }
}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = ImageHeaderComponentLayout
public struct ImageHeaderComponent: ImageHeaderComponentType {
// sourcery:inline:auto:ImageHeaderComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the ImageHeaderComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var id: String

    public var width: CGFloat = 0.0

    public var height: CGFloat = 100.0

    public var imageURL: String = ""

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return ImageHeaderComponentLayout(component: self) }

    public var identity: ImageHeaderComponent { return self }
// sourcery:end
}

public final class ImageHeaderComponentLayout: SizeLayout<UIView>, ComponentLayout {
    public init(component: ImageHeaderComponent) {
        let imageLayout: SizeLayout<UIImageView> = SizeLayout<UIImageView>(
            width: component.width,
            height: component.height,
            alignment: Alignment.fill,
            flexibility: Flexibility.high,
            viewReuseId: "\(ImageHeaderComponentLayout.identifier)_imageHeader",
            config: { (view: UIImageView) -> Void in
                view.contentMode = UIView.ContentMode.scaleAspectFill
                view.clipsToBounds = true
                view.loadImage(of: component.imageURL)
            }
        )

        super.init(
            minWidth: component.width,
            maxWidth: component.width,
            minHeight: component.height,
            maxHeight: component.height,
            alignment: Alignment.center,
            flexibility: Flexibility.low,
            viewReuseId: RestaurantComponentLayout.identifier,
            sublayout: imageLayout,
            config: nil
        )
    }
}
