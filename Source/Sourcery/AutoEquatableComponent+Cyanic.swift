// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
        case let (lValue?, rValue?):
            return compare(lValue, rValue)
        case (nil, nil):
            return true
        default:
            return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatableComponent
// MARK: - CategoriesComponent AutoEquatableComponent
extension CategoriesComponent: Equatable {}
public func == (lhs: CategoriesComponent, rhs: CategoriesComponent) -> Bool {
    guard lhs.text == rhs.text else { return false }
    guard lhs.category == rhs.category else { return false }
    guard compareOptionals(lhs: lhs.ratings, rhs: rhs.ratings, compare: ==) else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    guard lhs.height == rhs.height else { return false }
    return true
}
// MARK: - ErrorMessageComponent AutoEquatableComponent
extension ErrorMessageComponent: Equatable {}
public func == (lhs: ErrorMessageComponent, rhs: ErrorMessageComponent) -> Bool {
    guard lhs.errorMessage == rhs.errorMessage else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    guard lhs.height == rhs.height else { return false }
    return true
}
// MARK: - ImageHeaderComponent AutoEquatableComponent
extension ImageHeaderComponent: Equatable {}
public func == (lhs: ImageHeaderComponent, rhs: ImageHeaderComponent) -> Bool {
    guard lhs.height == rhs.height else { return false }
    guard lhs.imageURL == rhs.imageURL else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    return true
}
// MARK: - LocationComponent AutoEquatableComponent
extension LocationComponent: Equatable {}
public func == (lhs: LocationComponent, rhs: LocationComponent) -> Bool {
    guard lhs.height == rhs.height else { return false }
    guard compareOptionals(lhs: lhs.location, rhs: rhs.location, compare: ==) else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    return true
}
// MARK: - MenuPhotosComponent AutoEquatableComponent
extension MenuPhotosComponent: Equatable {}
public func == (lhs: MenuPhotosComponent, rhs: MenuPhotosComponent) -> Bool {
    guard lhs.menuURL == rhs.menuURL else { return false }
    guard lhs.photoURL == rhs.photoURL else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    guard lhs.height == rhs.height else { return false }
    return true
}
// MARK: - RestaurantComponent AutoEquatableComponent
extension RestaurantComponent: Equatable {}
public func == (lhs: RestaurantComponent, rhs: RestaurantComponent) -> Bool {
    guard compareOptionals(lhs: lhs.restaurant, rhs: rhs.restaurant, compare: ==) else { return false }
    guard lhs.isExpanded == rhs.isExpanded else { return false }
    guard lhs.height == rhs.height else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    return true
}
// MARK: - UserReviewComponent AutoEquatableComponent
extension UserReviewComponent: Equatable {}
public func == (lhs: UserReviewComponent, rhs: UserReviewComponent) -> Bool {
    guard compareOptionals(lhs: lhs.reviewer, rhs: rhs.reviewer, compare: ==) else { return false }
    guard lhs.rating == rhs.rating else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    guard lhs.height == rhs.height else { return false }
    return true
}
