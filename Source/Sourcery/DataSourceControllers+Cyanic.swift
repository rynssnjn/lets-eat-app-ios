// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Cyanic

// swiftlint:disable all
public extension ComponentsController {

    /**
        Generates a CategoriesComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable CategoriesComponent.
            - mutableComponent: The CategoriesComponent instance to be mutated/configured.
        - Returns:
            CategoriesComponent
    */
    @discardableResult
    mutating func categoriesComponent(configuration: (_ mutableComponent: inout CategoriesComponent) -> Void) -> CategoriesComponent {
        var mutableComponent: CategoriesComponent = CategoriesComponent(id: CyanicConstants.invalidID)
        configuration(&mutableComponent)
        mutableComponent.width = self.width
        guard ComponentStateValidator.hasValidIdentifier(mutableComponent)
            else { fatalError("You must have a unique identifier for this component") }
        self.add(mutableComponent)
        return mutableComponent
    }

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
        Generates a LocationComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable LocationComponent.
            - mutableComponent: The LocationComponent instance to be mutated/configured.
        - Returns:
            LocationComponent
    */
    @discardableResult
    mutating func locationComponent(configuration: (_ mutableComponent: inout LocationComponent) -> Void) -> LocationComponent {
        var mutableComponent: LocationComponent = LocationComponent(id: CyanicConstants.invalidID)
        configuration(&mutableComponent)
        mutableComponent.width = self.width
        guard ComponentStateValidator.hasValidIdentifier(mutableComponent)
            else { fatalError("You must have a unique identifier for this component") }
        self.add(mutableComponent)
        return mutableComponent
    }

    /**
        Generates a MenuPhotosComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable MenuPhotosComponent.
            - mutableComponent: The MenuPhotosComponent instance to be mutated/configured.
        - Returns:
            MenuPhotosComponent
    */
    @discardableResult
    mutating func menuPhotosComponent(configuration: (_ mutableComponent: inout MenuPhotosComponent) -> Void) -> MenuPhotosComponent {
        var mutableComponent: MenuPhotosComponent = MenuPhotosComponent(id: CyanicConstants.invalidID)
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
        Generates a CategoriesComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable CategoriesComponent.
            - mutableComponent: The CategoriesComponent instance to be mutated/configured.
        - Returns:
            CategoriesComponent
    */
    @discardableResult
    mutating func categoriesComponent(for supplementaryView: SectionController.SupplementaryView, configuration: (_ mutableComponent: inout CategoriesComponent) -> Void) -> CategoriesComponent {
        var mutableComponent: CategoriesComponent = CategoriesComponent(id: CyanicConstants.invalidID)
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
        Generates a LocationComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable LocationComponent.
            - mutableComponent: The LocationComponent instance to be mutated/configured.
        - Returns:
            LocationComponent
    */
    @discardableResult
    mutating func locationComponent(for supplementaryView: SectionController.SupplementaryView, configuration: (_ mutableComponent: inout LocationComponent) -> Void) -> LocationComponent {
        var mutableComponent: LocationComponent = LocationComponent(id: CyanicConstants.invalidID)
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
        Generates a MenuPhotosComponent instance and configures its properties with the given closure. You must provide a
        unique id in the configuration block, otherwise it will force a fatalError.
        - Parameters:
            - configuration: The closure that mutates the mutable MenuPhotosComponent.
            - mutableComponent: The MenuPhotosComponent instance to be mutated/configured.
        - Returns:
            MenuPhotosComponent
    */
    @discardableResult
    mutating func menuPhotosComponent(for supplementaryView: SectionController.SupplementaryView, configuration: (_ mutableComponent: inout MenuPhotosComponent) -> Void) -> MenuPhotosComponent {
        var mutableComponent: MenuPhotosComponent = MenuPhotosComponent(id: CyanicConstants.invalidID)
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
