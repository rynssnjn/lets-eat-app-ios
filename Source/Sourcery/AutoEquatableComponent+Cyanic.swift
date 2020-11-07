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
// MARK: - RestaurantComponent AutoEquatableComponent
extension RestaurantComponent: Equatable {}
public func == (lhs: RestaurantComponent, rhs: RestaurantComponent) -> Bool {
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard lhs.isExpanded == rhs.isExpanded else { return false }
    guard lhs.height == rhs.height else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.width == rhs.width else { return false }
    return true
}
