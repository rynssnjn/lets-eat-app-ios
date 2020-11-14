//
//  CategoriesComponent.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = CategoriesComponent
public protocol CategoriesComponentType: StaticHeightComponent {

    // sourcery: defaultValue = """"
    var text: String { get set }

    // sourcery: defaultValue = "Category.time"
    var category: Category { get set }

    var ratings: Ratings? { get set }
}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = CategoriesComponentLayout
public struct CategoriesComponent: CategoriesComponentType {
// sourcery:inline:auto:CategoriesComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the CategoriesComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var text: String = ""

    public var category: Category = Category.time

    public var ratings: Ratings?

    public var id: String

    public var width: CGFloat = 0.0

    public var height: CGFloat = 44.0

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return CategoriesComponentLayout(component: self) }

    public var identity: CategoriesComponent { return self }
// sourcery:end
}

public final class CategoriesComponentLayout: SizeLayout<UIView>, ComponentLayout {
    public init(component: CategoriesComponent) {
        let insets: EdgeInsets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)

        let titleLayout: LabelLayout<UILabel> = LabelLayout(
            text: Text.unattributed("\(component.category.title.localized):"),
            font: UIFont.systemFont(ofSize: 17.0),
            numberOfLines: 0,
            alignment: Alignment.center,
            flexibility: Flexibility.high,
            viewReuseId: "\(CategoriesComponentLayout.identifier)Category",
            config: { (view: UILabel) -> Void in
                view.textAlignment = NSTextAlignment.left
                view.lineBreakMode = NSLineBreakMode.byCharWrapping
            }
        )

        let valueLayout: LabelLayout<UILabel> = LabelLayout(
            text: Text.unattributed(component.text),
            font: UIFont.boldSystemFont(ofSize: 17.0),
            alignment: Alignment.centerTrailing,
            flexibility: Flexibility.high,
            viewReuseId: "\(CategoriesComponentLayout.identifier)LabelValue",
            config: nil
        )

        let horizontalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.horizontal,
            spacing: 10.0,
            distribution: StackLayoutDistribution.fillEqualSpacing,
            alignment: Alignment.fill,
            flexibility: Flexibility.low,
            sublayouts: [titleLayout, valueLayout]
        )

        let insetLayout: InsetLayout<UIView> = InsetLayout<UIView>(
            insets: insets,
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
