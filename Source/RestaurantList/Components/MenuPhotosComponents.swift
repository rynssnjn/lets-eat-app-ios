//
//  MenuPhotosComponents.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/13/20.
//

import Foundation
import Cyanic
import LayoutKit
import CommonWidgets
import RxSwift

// sourcery: AutoEquatableComponent,AutoHashableComponent
// sourcery: Component = MenuPhotosComponent
public protocol MenuPhotosComponentType: StaticHeightComponent {

    // sourcery: defaultValue = """"
    var menuURL: String { get set }

    // sourcery: defaultValue = """"
    var photoURL: String { get set }

    // sourcery: skipEquality, skipHashing
    // sourcery: defaultValue = "{ fatalError("Must be overridden") }"
    var onMenuButtonTapped: () -> Void { get set }

    // sourcery: skipEquality, skipHashing
    // sourcery: defaultValue = "{ fatalError("Must be overridden") }"
    var onPhotosButtonTapped: () -> Void { get set }

}

// sourcery: AutoGenerateComponent,AutoGenerateComponentExtension
// sourcery: ComponentLayout = MenuPhotosComponentLayout
public struct MenuPhotosComponent: MenuPhotosComponentType {
// sourcery:inline:auto:MenuPhotosComponent.AutoGenerateComponent
    /**
     Work around Initializer because memberwise initializers are all or nothing
     - Parameters:
         - id: The unique identifier of the MenuPhotosComponent.
    */
    public init(id: String) {
        self.id = id
    }

    public var id: String

    public var width: CGFloat = 0.0

    public var menuURL: String = ""

    public var photoURL: String = ""

    // sourcery: skipHashing, skipEquality
    public var onMenuButtonTapped: () -> Void = { fatalError("Must be overridden") }

    // sourcery: skipHashing, skipEquality
    public var onPhotosButtonTapped: () -> Void = { fatalError("Must be overridden") }

    public var height: CGFloat = 44.0

    // sourcery: skipHashing, skipEquality
    public var layout: ComponentLayout { return MenuPhotosComponentLayout(component: self) }

    public var identity: MenuPhotosComponent { return self }
// sourcery:end
}

public final class MenuPhotosComponentLayout: SizeLayout<UIView>, ComponentLayout {
    private let disposeBag: DisposeBag
    public init(component: MenuPhotosComponent) { // swiftlint:disable:this function_body_length
        let disposeBag: DisposeBag = DisposeBag()

        let onManuTappedDisposable: SerialDisposable = SerialDisposable()
        let onPhotosTappedDisposable: SerialDisposable = SerialDisposable()

        onManuTappedDisposable.disposed(by: disposeBag)
        onPhotosTappedDisposable.disposed(by: disposeBag)

        let menuButtonLayout: ButtonLayout<UIButton> = ButtonLayout(
            type: ButtonLayoutType.custom,
            title: "view_menu".localized.uppercased(),
            alignment: Alignment.fill,
            flexibility: Flexibility.flexible,
            viewReuseId: "\(MenuPhotosComponentLayout.identifier)MenuButton",
            config: { (view: UIButton) -> Void in
                view.backgroundColor = UIColor.systemRed
                view.setTitleColor(UIColor.white, for: UIControl.State.normal)
                view.frame.size = CGSize(width: component.width / 2.0, height: component.height)
                onManuTappedDisposable.disposable = view.rx
                    .controlEvent(UIControl.Event.touchUpInside)
                    .bind(onNext: component.onMenuButtonTapped)
            }
        )

        let photosButtonLayout: ButtonLayout<UIButton> = ButtonLayout(
            type: ButtonLayoutType.custom,
            title: "view_photos".localized.uppercased(),
            alignment: Alignment.fill,
            flexibility: Flexibility.flexible,
            viewReuseId: "\(MenuPhotosComponentLayout.identifier)PhotosButton",
            config: { (view: UIButton) -> Void in
                view.backgroundColor = UIColor.systemGreen
                view.setTitleColor(UIColor.white, for: UIControl.State.normal)
                view.frame.size = CGSize(width: component.width / 2.0, height: component.height)
                onPhotosTappedDisposable.disposable = view.rx
                    .controlEvent(UIControl.Event.touchUpInside)
                    .bind(onNext: component.onPhotosButtonTapped)
            }
        )

        let horizontalStackLayout: StackLayout<UIView> = StackLayout<UIView>(
            axis: Axis.horizontal,
            spacing: 0.0,
            distribution: StackLayoutDistribution.fillEqualSize,
            alignment: Alignment.aspectFit,
            flexibility: Flexibility.low,
            sublayouts: [menuButtonLayout, photosButtonLayout]
        )

        self.disposeBag = disposeBag
        super.init(
            minWidth: component.width,
            maxWidth: component.width,
            minHeight: component.height,
            maxHeight: component.height,
            alignment: Alignment.fill,
            flexibility: Flexibility.high,
            viewReuseId: "\(MenuPhotosComponentLayout.identifier)Size",
            sublayout: horizontalStackLayout,
            config: nil
        )
    }
}
