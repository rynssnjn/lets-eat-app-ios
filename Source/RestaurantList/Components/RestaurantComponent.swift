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

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = RestaurantComponent
public protocol RestaurantComponentType: StaticHeightComponent, Selectable {

    // sourcery: defaultValue = """"
    var title: String? { get set }

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

    public var title: String? = ""

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
        let chevronLayout: SizeLayout<ChevronView> = SizeLayout<ChevronView>(
            width: 20.0,
            height: 20.0,
            alignment: Alignment.centerTrailing,
            flexibility: Flexibility.low,
            viewReuseId: "\(RestaurantComponentLayout.identifier)Chevron",
            config: { (view: ChevronView) -> Void in
                view.direction = component.isExpanded ? ChevronView.Direction.down : ChevronView.Direction.right
                view.lineWidth = 2.0
            }
        )

        let deviceNameLayout: LabelLayout<UILabel> = LabelLayout(
            text: Text.unattributed(component.title!),
            font: UIFont.boldSystemFont(ofSize: 17.0),
            lineHeight: 100.0,
            numberOfLines: 0,
            alignment: Alignment.center,
            flexibility: Flexibility.high,
            viewReuseId: "\(RestaurantComponentLayout.identifier)Name",
            config: { (view: UILabel) -> Void in
                view.textAlignment = NSTextAlignment.left
                view.lineBreakMode = NSLineBreakMode.byCharWrapping
            }
        )

        let horizontalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.horizontal,
            spacing: 10.0,
            distribution: StackLayoutDistribution.fillEqualSpacing,
            alignment: Alignment.fill,
            flexibility: Flexibility.low,
            sublayouts: [deviceNameLayout, chevronLayout]
        )

        let insetLayout: InsetLayout<UIView> = InsetLayout<UIView>(
            insets: UIEdgeInsets(top: 10.0, left: 25.0, bottom: 10.0, right: 20.0),
            alignment: Alignment.fill,
            sublayout: horizontalStackLayout,
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
            sublayout: insetLayout,
            config: nil
        )
    }
}
