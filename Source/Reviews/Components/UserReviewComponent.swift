//
//  UserReviewComponent.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets
import StarryStars

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = UserReviewComponent
public protocol UserReviewComponentType: StaticHeightComponent, Selectable {

    var reviewer: Reviewer? { get set }

    // sourcery: defaultValue = "0.0"
    var rating: CGFloat { get set }

    // sourcery: skipHashing,skipEquality
    // sourcery: defaultValue = "{ () -> Void in fatalError("This default closure must be replaced!") }"
    var onTap: () -> Void { get set }

}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = UserReviewComponentLayout
public struct UserReviewComponent: UserReviewComponentType {

// sourcery:inline:auto:UserReviewComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the UserReviewComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var id: String

    public var width: CGFloat = 0.0

    public var height: CGFloat = 44.0

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return UserReviewComponentLayout(component: self) }

    public var reviewer: Reviewer?

    public var rating: CGFloat = 0.0

    // sourcery: skipHashing, skipEquality
    public var onTap: () -> Void = { () -> Void in fatalError("This default closure must be replaced!") }

    public var identity: UserReviewComponent { return self }
// sourcery:end

    public func onSelect(_ view: UIView) {
        self.onTap()
    }
}

public final class UserReviewComponentLayout: SizeLayout<UIView>, ComponentLayout {
    public init(component: UserReviewComponent) { // swiftlint:disable:this function_body_length
        let thumbnailImageLayout: SizeLayout<UIImageView> = SizeLayout<UIImageView>(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.centerLeading,
            flexibility: Flexibility.high,
            viewReuseId: "\(UserReviewComponentLayout.identifier)thumbnail",
            config: { (view: UIImageView) -> Void in
                guard let reviewer = component.reviewer else { return }
                view.loadImage(of: reviewer.imageURL)
                view.contentMode = UIView.ContentMode.scaleAspectFill
                view.clipsToBounds = true
                view.layer.cornerRadius = 12.0
            }
        )

        let restaurantNameLayout: LabelLayout<UILabel> = LabelLayout(
            text: Text.unattributed(component.reviewer?.name ?? ""),
            font: UIFont.boldSystemFont(ofSize: 17.0),
            lineHeight: 100.0,
            numberOfLines: 0,
            alignment: Alignment.centerLeading,
            flexibility: Flexibility.high,
            viewReuseId: "\(UserReviewComponentLayout.identifier)Name",
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
            viewReuseId: "\(UserReviewComponentLayout.identifier)Stars",
            config: { (view: RatingView) -> Void in
                view.editable = false
                view.onImage = #imageLiteral(resourceName: "filled_star").resize(width: 15.0)
                view.offImage = #imageLiteral(resourceName: "unfilled_star").resize(width: 15.0)
                view.halfImage = #imageLiteral(resourceName: "half_star").resize(width: 15.0)
                view.starCount = 5
                view.rating = component.rating.rsj.asFloat
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

        let reviewerLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.horizontal,
            spacing: 20.0,
            distribution: StackLayoutDistribution.leading,
            alignment: Alignment.fill,
            flexibility: Flexibility.inflexible,
            sublayouts: [thumbnailImageLayout, verticalStackLayout]
        )

        let insetLayout: InsetLayout<UIView> = InsetLayout<UIView>(
            insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0),
            alignment: Alignment.fill,
            sublayout: reviewerLayout,
            config: nil
        )

        super.init(
            minWidth: component.width,
            maxWidth: component.width,
            minHeight: component.height,
            maxHeight: component.height,
            alignment: Alignment.center,
            flexibility: Flexibility.low,
            viewReuseId: UserReviewComponentLayout.identifier,
            sublayout: insetLayout,
            config: nil
        )
    }
}
