//
//  ErrorMessageComponent.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = ErrorMessageComponent
public protocol ErrorMessageComponentType: StaticHeightComponent {

    // sourcery: defaultValue = """"
    var errorMessage: String { get set }
}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = ErrorMessageComponentLayout
public struct ErrorMessageComponent: ErrorMessageComponentType {
// sourcery:inline:auto:ErrorMessageComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the ErrorMessageComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var id: String

    public var width: CGFloat = 0.0

    public var errorMessage: String = ""

    public var height: CGFloat = 44.0

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return ErrorMessageComponentLayout(component: self) }

    public var identity: ErrorMessageComponent { return self }
// sourcery:end
}

public final class ErrorMessageComponentLayout: SizeLayout<UIView>, ComponentLayout {
    public init(component: ErrorMessageComponent) { // swiftlint:disable:this function_body_length
        let imageLayout: SizeLayout<UIImageView> = SizeLayout<UIImageView>(
            width: component.height / 2.0,
            height: component.height / 2.0,
            alignment: Alignment.center,
            flexibility: Flexibility.inflexible,
            viewReuseId: "\(ErrorMessageComponentLayout.identifier)Icon",
            config: { (view: UIImageView) -> Void in
                view.contentMode = UIView.ContentMode.scaleAspectFit
                view.clipsToBounds = true
                view.image = #imageLiteral(resourceName: "error_icon")
            }
        )

        let errorMessageLayout: LabelLayout<UILabel> = LabelLayout(
            text: Text.unattributed(component.errorMessage),
            font: UIFont.boldSystemFont(ofSize: 17.0),
            numberOfLines: 0,
            alignment: Alignment.center,
            flexibility: Flexibility.inflexible,
            viewReuseId: "\(ErrorMessageComponentLayout.identifier)Message",
            config: { (view: UILabel) -> Void in
                view.textAlignment = NSTextAlignment.center
                view.lineBreakMode = NSLineBreakMode.byCharWrapping
            }
        )

        let verticalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.vertical,
            spacing: 0.0,
            distribution: StackLayoutDistribution.center,
            alignment: Alignment.fill,
            flexibility: Flexibility.inflexible,
            sublayouts: [imageLayout, errorMessageLayout]
        )

        let insetLayout: InsetLayout<UIView> = InsetLayout<UIView>(
            insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0),
            alignment: Alignment.fill,
            sublayout: verticalStackLayout,
            config: nil
        )

        super.init(
            minWidth: component.width,
            maxWidth: component.width,
            minHeight: component.height,
            maxHeight: component.height,
            alignment: Alignment.center,
            flexibility: Flexibility.low,
            viewReuseId: ErrorMessageComponentLayout.identifier,
            sublayout: insetLayout,
            config: nil
        )
    }
}
