//
//  RestaurantComponent.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets
import StarryStars

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = RestaurantComponent
public protocol RestaurantComponentType: StaticHeightComponent, Selectable {

    var restaurant: Restaurant? { get set }

    /**
     The action to set the expandable state to expanded or not expanded.
    */
    // sourcery: skipHashing,skipEquality
    // sourcery: defaultValue = "{ (_: String, _: Bool) -> Void in fatalError("This default closure must be replaced!") }"
    var setExpandableState: (String, Bool) -> Void { get set }

    /**
     Boolean if component is expanded or not
    */
    // sourcery: defaultValue = "false"
    var isExpanded: Bool { get set }

    // sourcery: defaultValue = "60.0"
    var height: CGFloat { get set }
}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = RestaurantComponentLayout
public struct RestaurantComponent: RestaurantComponentType {
// sourcery:inline:auto:RestaurantComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the RestaurantComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var id: String

    public var width: CGFloat = 0.0

    public var restaurant: Restaurant?

    // sourcery: skipHashing, skipEquality
    public var setExpandableState: (String, Bool) -> Void = { (_: String, _: Bool) -> Void in fatalError("This default closure must be replaced!") }

    public var isExpanded: Bool = false

    public var height: CGFloat = 60.0

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return RestaurantComponentLayout(component: self) }

    public var identity: RestaurantComponent { return self }
// sourcery:end
    public func onSelect(_ view: UIView) {
        self.setExpandableState(self.id, !self.isExpanded)
    }
}

public final class RestaurantComponentLayout: SizeLayout<UIView>, ComponentLayout {
    public init(component: RestaurantComponent) { // swiftlint:disable:this function_body_length
        let commonInset: EdgeInsets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
        let thumbnailImageLayout: SizeLayout<UIImageView> = SizeLayout<UIImageView>(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.centerTrailing,
            flexibility: Flexibility.high,
            viewReuseId: "\(RestaurantComponentLayout.identifier)thumbnail",
            config: { (view: UIImageView) -> Void in
                view.loadImage(of: component.restaurant?.thumbnailURL ?? "")
                view.contentMode = UIView.ContentMode.scaleAspectFill
                view.clipsToBounds = true
                view.layer.cornerRadius = 12.0
            }
        )

        let restaurantNameLayout: LabelLayout<UILabel> = LabelLayout(
            text: Text.unattributed(component.restaurant?.name ?? ""),
            font: UIFont.boldSystemFont(ofSize: 17.0),
            lineHeight: 100.0,
            numberOfLines: 0,
            alignment: Alignment.centerLeading,
            flexibility: Flexibility.high,
            viewReuseId: "\(RestaurantComponentLayout.identifier)Name",
            config: { (view: UILabel) -> Void in
                view.textAlignment = NSTextAlignment.left
                view.lineBreakMode = NSLineBreakMode.byCharWrapping
            }
        )

        let starsLayout: SizeLayout<RatingView> = SizeLayout<RatingView>(
            width: 80,
            height: 20.0,
            alignment: Alignment.centerLeading,
            flexibility: Flexibility.high,
            viewReuseId: "\(RestaurantComponentLayout.identifier)Stars",
            config: { (view: RatingView) -> Void in
                view.editable = false
                view.onImage = #imageLiteral(resourceName: "filled_star").resize(width: 15.0)
                view.offImage = #imageLiteral(resourceName: "unfilled_star").resize(width: 15.0)
                view.halfImage = #imageLiteral(resourceName: "half_star").resize(width: 15.0)
                view.starCount = 5
                view.rating = component.restaurant?.ratings.average.rsj.asFloat ?? 0.0
            }
        )

        let chevronLayout: SizeLayout<ChevronView> = SizeLayout<ChevronView>(
            width: 15.0,
            height: 15.0,
            alignment: Alignment.centerTrailing,
            flexibility: Flexibility.low,
            viewReuseId: "\(RestaurantComponentLayout.identifier)Chevron",
            config: { (view: ChevronView) -> Void in
                view.direction = component.isExpanded ? ChevronView.Direction.down : ChevronView.Direction.right
                view.lineWidth = 2.0
            }
        )

        let verticalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.vertical,
            spacing: 1.0,
            distribution: StackLayoutDistribution.leading,
            alignment: Alignment.centerLeading,
            flexibility: Flexibility.high,
            sublayouts: [restaurantNameLayout, starsLayout]

        )

        let restaurantStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.horizontal,
            spacing: 20.0,
            distribution: StackLayoutDistribution.trailing,
            alignment: Alignment.fill,
            flexibility: Flexibility.inflexible,
            sublayouts: [thumbnailImageLayout, verticalStackLayout]
        )

        let horizontalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.horizontal,
            spacing: 10.0,
            distribution: StackLayoutDistribution.fillEqualSpacing,
            alignment: Alignment.fill,
            flexibility: Flexibility.low,
            sublayouts: [restaurantStackLayout, chevronLayout]
        )

        let insetLayout: InsetLayout<UIView> = InsetLayout<UIView>(
            insets: commonInset,
            alignment: Alignment.fill,
            sublayout: horizontalStackLayout,
            config: nil
        )

        let dividerLayout: SizeLayout<UIView> = SizeLayout<UIView>(
            width: component.width,
            height: 1.0,
            flexibility: Flexibility.inflexible,
            viewReuseId: "\(RestaurantComponentLayout.identifier)Divider",
            config: { (view: UIView) -> Void in
                view.backgroundColor = UIColor.rsj.color(red: 229, green: 229, blue: 234)
            }
        )

        let dividerInset: InsetLayout<UIView> = InsetLayout<UIView>(
            insets: commonInset,
            alignment: Alignment.fill,
            sublayout: dividerLayout,
            config: nil
        )

        let cellStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.vertical,
            spacing: 0.0,
            alignment: Alignment.fill,
            flexibility: Flexibility.inflexible,
            sublayouts: [insetLayout, dividerInset],
            config: nil
        )

        super.init(
            minWidth: component.width,
            maxWidth: component.width,
            minHeight: component.height,
            maxHeight: component.height,
            alignment: Alignment.center,
            flexibility: Flexibility.low,
            viewReuseId: RestaurantComponentLayout.identifier,
            sublayout: cellStackLayout,
            config: nil
        )
    }
}
