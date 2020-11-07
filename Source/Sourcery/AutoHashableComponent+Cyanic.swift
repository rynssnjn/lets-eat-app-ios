// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all
// MARK: - AutoHashableComponent
// MARK: - RestaurantComponent AutoHashableComponent
extension RestaurantComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.title.hash(into: &hasher)
        self.isExpanded.hash(into: &hasher)
        self.height.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
    }
}
