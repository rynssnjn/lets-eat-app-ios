// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Cyanic

// swiftlint:disable all
public extension ComponentsController {

    /**
        Generates a ImageHeaderComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable ImageHeaderComponent.
            - mutableComponent: The ImageHeaderComponent instance to be mutated/configured.
        - Returns:
            ImageHeaderComponent
    */
    @discardableResult
    mutating func imageHeaderComponent(configuration: (_ mutableComponent: inout ImageHeaderComponent) -> Void) -> ImageHeaderComponent {
        var mutableComponent: ImageHeaderComponent = ImageHeaderComponent(id: CyanicConstants.invalidID)
        configuration(&mutableComponent)
        mutableComponent.width = self.width
        guard ComponentStateValidator.hasValidIdentifier(mutableComponent)
            else { fatalError("You must have a unique identifier for this component") }
        self.add(mutableComponent)
        return mutableComponent
    }

    /**
        Generates a RestaurantComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable RestaurantComponent.
            - mutableComponent: The RestaurantComponent instance to be mutated/configured.
        - Returns:
            RestaurantComponent
    */
    @discardableResult
    mutating func restaurantComponent(configuration: (_ mutableComponent: inout RestaurantComponent) -> Void) -> RestaurantComponent {
        var mutableComponent: RestaurantComponent = RestaurantComponent(id: CyanicConstants.invalidID)
        configuration(&mutableComponent)
        mutableComponent.width = self.width
        guard ComponentStateValidator.hasValidIdentifier(mutableComponent)
            else { fatalError("You must have a unique identifier for this component") }
        self.add(mutableComponent)
        return mutableComponent
    }
}

public extension SectionController {

    /**
        Generates a ImageHeaderComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable ImageHeaderComponent.
            - mutableComponent: The ImageHeaderComponent instance to be mutated/configured.
        - Returns:
            ImageHeaderComponent
    */
    @discardableResult
    mutating func imageHeaderComponent(for supplementaryView: SectionController.SupplementaryView, configuration: (_ mutableComponent: inout ImageHeaderComponent) -> Void) -> ImageHeaderComponent {
        var mutableComponent: ImageHeaderComponent = ImageHeaderComponent(id: CyanicConstants.invalidID)
        configuration(&mutableComponent)
        mutableComponent.width = self.width
        guard ComponentStateValidator.hasValidIdentifier(mutableComponent)
            else { fatalError("You must have a unique identifier for this component") }

        switch supplementaryView {
            case .header:
                self.headerComponent = mutableComponent.asAnyComponent
            case .footer:
                self.footerComponent = mutableComponent.asAnyComponent
        }

        return mutableComponent
    }

    /**
        Generates a RestaurantComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable RestaurantComponent.
            - mutableComponent: The RestaurantComponent instance to be mutated/configured.
        - Returns:
            RestaurantComponent
    */
    @discardableResult
    mutating func restaurantComponent(for supplementaryView: SectionController.SupplementaryView, configuration: (_ mutableComponent: inout RestaurantComponent) -> Void) -> RestaurantComponent {
        var mutableComponent: RestaurantComponent = RestaurantComponent(id: CyanicConstants.invalidID)
        configuration(&mutableComponent)
        mutableComponent.width = self.width
        guard ComponentStateValidator.hasValidIdentifier(mutableComponent)
            else { fatalError("You must have a unique identifier for this component") }

        switch supplementaryView {
            case .header:
                self.headerComponent = mutableComponent.asAnyComponent
            case .footer:
                self.footerComponent = mutableComponent.asAnyComponent
        }

        return mutableComponent
    }
}
// swiftlint:enable all
