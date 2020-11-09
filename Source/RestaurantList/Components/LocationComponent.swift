//
//  LocationComponent.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/9/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = LocationComponent
public protocol LocationComponentType: StaticHeightComponent, Selectable {

    // sourcery: defaultValue = "250.0"
    var height: CGFloat { get set }

    var location: Location? { get set }

    // sourcery: skipHashing,skipEquality
    // sourcery: defaultValue = "{ () -> Void in fatalError("This default closure must be replaced!") }"
    var onTap: () -> Void { get set }

}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = LocationComponentLayout
public struct LocationComponent: LocationComponentType {
// sourcery:inline:auto:LocationComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the LocationComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var id: String

    public var width: CGFloat = 0.0

    public var height: CGFloat = 250.0

    public var location: Location?

    // sourcery: skipHashing, skipEquality
    public var onTap: () -> Void = { () -> Void in fatalError("This default closure must be replaced!") }

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return LocationComponentLayout(component: self) }

    public var identity: LocationComponent { return self }
// sourcery:end

    public func onSelect(_ view: UIView) {
        self.onTap()
    }
}

public final class LocationComponentLayout: SizeLayout<UIView>, ComponentLayout {
    public init(component: LocationComponent) {
        let mapImageLayout: SizeLayout<UIImageView> = SizeLayout<UIImageView>(
            width: component.width,
            height: component.height,
            alignment: Alignment.fill,
            flexibility: Flexibility.high,
            viewReuseId: "\(LocationComponentLayout.identifier)MapImage",
            config: { (view: UIImageView) -> Void in
                view.contentMode = UIView.ContentMode.scaleAspectFill
                view.clipsToBounds = true
                if let location = component.location {
                    view.loadMapImage(of: location)
                }
            }
        )

//        let addressLayout: LabelLayout<UILabel> = LabelLayout(
//            text: Text.unattributed(component.location?.address ?? ""),
//            font: UIFont.systemFont(ofSize: 15.0),
//            numberOfLines: 0,
//            alignment: Alignment.centerLeading,
//            flexibility: Flexibility.high,
//            viewReuseId: "\(LocationComponentLayout.identifier)Address",
//            config: { (view: UILabel) -> Void in
//                view.textColor = UIColor.systemBlue
//                view.textAlignment = NSTextAlignment.left
//                view.lineBreakMode = NSLineBreakMode.byCharWrapping
//            }
//        )
//
//        let insetLayout: InsetLayout<UIView> = InsetLayout<UIView>(
//            insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0),
//            alignment: Alignment.fill,
//            sublayout: addressLayout,
//            config: nil
//        )
//
//        let verticalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
//            axis: Axis.vertical,
//            spacing: 0.0,
//            alignment: Alignment.fill,
//            flexibility: Flexibility.low,
//            sublayouts: [mapImageLayout, insetLayout],
//            config: nil
//        )

        super.init(
            minWidth: component.width,
            maxWidth: component.width,
            minHeight: component.height,
            maxHeight: component.height,
            alignment: Alignment.fill,
            flexibility: Flexibility.low,
            viewReuseId: RestaurantComponentLayout.identifier,
            sublayout: mapImageLayout,
            config: nil
        )
    }
}
