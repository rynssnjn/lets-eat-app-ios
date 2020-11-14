// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable all
// MARK: - AutoHashableComponent
// MARK: - CategoriesComponent AutoHashableComponent
extension CategoriesComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.text.hash(into: &hasher)
        self.category.hash(into: &hasher)
        self.ratings.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
        self.height.hash(into: &hasher)
    }
}
// MARK: - ImageHeaderComponent AutoHashableComponent
extension ImageHeaderComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.height.hash(into: &hasher)
        self.imageURL.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
    }
}
// MARK: - LocationComponent AutoHashableComponent
extension LocationComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.height.hash(into: &hasher)
        self.location.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
    }
}
// MARK: - MenuPhotosComponent AutoHashableComponent
extension MenuPhotosComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.menuURL.hash(into: &hasher)
        self.photoURL.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
        self.height.hash(into: &hasher)
    }
}
// MARK: - RestaurantComponent AutoHashableComponent
extension RestaurantComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.restaurant.hash(into: &hasher)
        self.isExpanded.hash(into: &hasher)
        self.height.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
    }
}
// MARK: - UserReviewComponent AutoHashableComponent
extension UserReviewComponent: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.reviewer.hash(into: &hasher)
        self.rating.hash(into: &hasher)
        self.id.hash(into: &hasher)
        self.width.hash(into: &hasher)
        self.height.hash(into: &hasher)
    }
}
