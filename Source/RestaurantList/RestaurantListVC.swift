//
//  RestaurantListVC.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/7/20.
//

import Foundation
import RxSwift
import RxDataSources
import Cyanic
import LayoutKit
import CoreLocation
import CommonWidgets

public final class RestaurantListVC: MultiSectionTableComponentViewController {

    // MARK: Delegate Properties
    private unowned let delegate: RestaurantListVCDelegate

    // MARK: Initializers
    public init(delegate: RestaurantListVCDelegate) {
        self.delegate = delegate
        let state: RestaurantListState = RestaurantListState.default

        self.viewModel = RestaurantListVM(initialState: state)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Stored Properties
    private let viewModel: RestaurantListVM
    private let locationManager: CLLocationManager = CLLocationManager()

    // MARK: Computed Properties
    public override var viewModels: [AnyViewModel] {
        return [
            self.viewModel.asAnyViewModel
        ]
    }

    private var computedHeight: CGFloat {
        return UIScreen.main.bounds.height * 0.8
    }

    // MARK: UIViewController LifeCycle Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.checkLocationAuthorization()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "disclaimer".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(RestaurantListVC.librariesItemTapped)
        )

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "reviews".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(RestaurantListVC.reviewButtonItemTapped)
        )
    }

    // MARK: Instance Methods
    private func checkLocationAuthorization() {
        switch CLLocationManager.locationServicesEnabled() {
            case true:
                switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()

                    case .denied, .restricted:
                        return

                    case .authorizedAlways, .authorizedWhenInUse:
                        self.locationManager.startUpdatingLocation()

                    @unknown default:
                        return
                }
            case false:
                return
        }
    }

    private func openDetails(id: String, isExpanded: Bool) {
        self.viewModel.setState { (state: inout RestaurantListState) -> Void in
            state.expandableDict[id] = isExpanded
            state.expandableDict.keys.filter { $0 != id }
                .forEach { state.expandableDict[$0] = false }
            state.selectedRestaurant = state.expandableDict.values.contains(true)
                ? state.restaurants.first(where: { $0.id == id }) : nil
        }
    }

    private func getRestaurants() {
        self.viewModel.getRestaurants()
    }

    private func openMaps(restaurant: Restaurant) {
        self.delegate.openMaps(restaurant: restaurant)
    }

    public override func invalidate() {
        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
            guard let s = self else { return }
            state.isLoading && state.restaurants.isEmpty ? s.rsj.showActivityIndicator() : s.rsj.hideActivityIndicator()
            if let reviewButton = s.navigationItem.rightBarButtonItem {
                reviewButton.isEnabled = state.selectedRestaurant != nil
            }
        }
    }

    public override func setUpDataSource() -> RxTableViewSectionedAnimatedDataSource<SectionController> {
        let dataSource = super.setUpDataSource()
        dataSource.animationConfiguration = AnimationConfiguration(
            insertAnimation: UITableView.RowAnimation.fade,
            reloadAnimation: UITableView.RowAnimation.fade,
            deleteAnimation: UITableView.RowAnimation.fade
        )

        return dataSource
    }

    // swiftlint:disable:next function_body_length
    public override func buildSections(_ sectionsController: inout MultiSectionController) {
        Cyanic.withState(of: self.viewModel) { (state: RestaurantListState) -> Void in
            sectionsController.sectionController { [weak self] (sectionController: inout SectionController) -> Void in
                guard let s = self else { return }
                if state.currentLocation == nil && state.isLoading == false {
                    sectionController.errorMessageComponent(for: SectionController.SupplementaryView.header) {
                        (component: inout ErrorMessageComponent) -> Void in
                        component.id = "ErrorMessage"
                        component.height = s.computedHeight
                        component.errorMessage = "location_error".localized
                    }
                } else {
                    if state.isLoading == false && state.restaurants.isEmpty {
                        sectionController.errorMessageComponent(for: SectionController.SupplementaryView.header) {
                            (component: inout ErrorMessageComponent) -> Void in
                            component.id = "NoRestaurantError"
                            component.height = s.computedHeight
                            component.errorMessage = "no_restaurants".localized
                        }
                    } else {
                        sectionController.staticLabelComponent(for: SectionController.SupplementaryView.header) {
                            (component: inout StaticLabelComponent) -> Void in
                            component.id = "Title"
                            component.backgroundColor = UIColor.white
                            component.text = Text.unattributed("nearby_restaurants".localized)
                            component.font = UIFont.boldSystemFont(ofSize: 25.0)
                            component.alignment = Alignment.centerLeading
                            component.configuration = { (view: UILabel) -> Void in
                                view.textColor = UIColor.black
                            }
                            component.insets = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 15.0)
                        }
                        sectionController.buildComponents { (componentsController: inout ComponentsController) -> Void in
                            let insets: EdgeInsets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)

                            state.restaurants.forEach { (restaurant: Restaurant) -> Void in
                                let restaurantId: String = restaurant.id
                                let restaurantComponent: RestaurantComponent = componentsController
                                    .restaurantComponent { (component: inout RestaurantComponent) -> Void in
                                        let id: String = restaurantId
                                        let isExpanded: Bool = state.expandableDict[id] == true
                                        component.id = id
                                        component.isExpanded = isExpanded
                                        component.restaurant = restaurant
                                        component.setExpandableState = { (id: String, isExpanded: Bool) -> Void in
                                            s.openDetails(id: id, isExpanded: isExpanded)
                                        }
                                }

                                if restaurantComponent.isExpanded {
                                    componentsController.locationComponent { (component: inout LocationComponent) -> Void in
                                        component.id = "\(restaurantId)Location"
                                        component.location = restaurant.location
                                        component.onTap = { () -> Void in
                                            s.openMaps(restaurant: restaurant)
                                        }
                                    }

                                    componentsController.buttonComponent { (component: inout ButtonComponent) -> Void in
                                        component.id = "\(restaurantId)Address"
                                        component.title = restaurant.location.address
                                        component.height = 60.0
                                        component.insets = insets
                                        component.configuration = { (view: UIButton) -> Void in
                                            view.titleLabel?.numberOfLines = 0
                                        }
                                        component.onTap = { (_: UIButton) -> Void in
                                            s.openMaps(restaurant: restaurant)
                                        }
                                    }

                                    componentsController.imageHeaderComponent { (component: inout ImageHeaderComponent) -> Void in
                                        component.id = "\(restaurantId)ImageHeader"
                                        component.imageURL = restaurant.featuredImage
                                    }

                                    componentsController.categoriesComponent { (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurantId)Schedule"
                                        component.category = Category.time
                                        component.text = restaurant.schedule
                                    }

                                    componentsController.categoriesComponent { (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurantId)Type"
                                        component.category = Category.type
                                        component.text = restaurant.type
                                    }

                                    componentsController.menuPhotosComponent { (component: inout MenuPhotosComponent) -> Void in
                                        component.id = "\(restaurantId)Buttons"
                                        component.height = 60.0
                                        component.onMenuButtonTapped = { () -> Void in
                                            s.delegate.gotToWeb(url: restaurant.menuURL)
                                        }
                                        component.onPhotosButtonTapped = { () -> Void in
                                            s.delegate.gotToWeb(url: restaurant.photosURL)
                                        }
                                    }
                                }
                            }

                            if state.restaurants.isEmpty == false && state.isLoading == false {
                                componentsController.buttonComponent { (component: inout ButtonComponent) -> Void in
                                    component.id = "loadMoreButton"
                                    component.title = "load_more".localized
                                    component.onTap = { (_: UIButton) -> Void in
                                        s.getRestaurants()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: Target Action Functions
    @objc func librariesItemTapped() {
        self.delegate.goToAcknowledgements()
    }

    @objc func reviewButtonItemTapped() {
        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
            guard let s = self else { return }
            if let restaurant = state.selectedRestaurant {
                s.delegate.goToReviews(restaurant: restaurant)
            }
        }
    }
}

// MARK: CLLocationManagerDelegate Methods
extension RestaurantListVC: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
                guard let s = self else { return }
                if let location = locations.first, state.currentLocation == nil {
                    s.viewModel.set(currentLocation: location)
                }
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation()
                print("Authorized")

            case .denied, .restricted:
                print("Denied/Restricted location services")

            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                print("Not Determined")
            @unknown default:
                print("")
        }
    }
}
