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
import Astral
import CoreLocation
import CommonWidgets

public final class RestaurantListVC: MultiSectionTableComponentViewController {

    // MARK: Delegate Properties
    private unowned var delegate: RestaurantListVCDelegate

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

    // MARK: UIViewController LifeCycle Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.checkLocationAuthorization()
        self.getRestaurants()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Disclaimer",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(RestaurantListVC.librariesItemTapped)
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
        }
    }

    private func getRestaurants() {
        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
            guard let s = self else { return }
            s.viewModel.getRestaurants(page: state.currentPage)
        }
    }

    private func openMaps(location: Location) {
        guard
            let latitude = location.latitude.rsj.asCGFloat,
            let longitude = location.longitude.rsj.asCGFloat
        else {
            return
        }

        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(latitude),
            longitude: CLLocationDegrees(longitude)
        )

        self.delegate.openMaps(coordinates: coordinates)
    }

    public override func invalidate() {
        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
            guard let s = self else { return }
            state.isLoading && state.restaurants.isEmpty ? s.rsj.showActivityIndicator() : s.rsj.hideActivityIndicator()
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
            sectionsController.sectionController { (sectionController: inout SectionController) -> Void in
                sectionController.staticLabelComponent(for: SectionController.SupplementaryView.header) {
                    (component: inout StaticLabelComponent) -> Void in
                    component.id = "Title"
                    component.backgroundColor = UIColor.white
                    component.text = Text.unattributed("Nearby Restaurants")
                    component.font = UIFont.boldSystemFont(ofSize: 25.0)
                    component.alignment = Alignment.centerLeading
                    component.configuration = { (view: UILabel) -> Void in
                        view.textColor = UIColor.black
                    }
                    component.insets = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 15.0)
                }
                sectionController.buildComponents { [weak self]
                    (componentsController: inout ComponentsController) -> Void in
                        let insets: EdgeInsets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
                        guard let s = self else { return }

                        state.restaurants.forEach { (restaurant: Restaurant) -> Void in
                            let restaurantComponent: RestaurantComponent = componentsController
                                .restaurantComponent { (component: inout RestaurantComponent) -> Void in
                                    let id: String = restaurant.id
                                    let isExpanded: Bool = state.expandableDict[id] == true
                                    component.id = id
                                    component.isExpanded = isExpanded
                                    component.restaurant = restaurant
                                    component.setExpandableState = { (id: String, isExpanded: Bool) -> Void in
                                        s.openDetails(id: id, isExpanded: isExpanded)
                                    }
                            }

                            if restaurantComponent.isExpanded {
                                componentsController.imageHeaderComponent {
                                    (component: inout ImageHeaderComponent) -> Void in
                                        component.id = "\(restaurant.id)ImageHeader"
                                        component.imageURL = restaurant.featuredImage
                                }
                                componentsController.buttonComponent {
                                    (component: inout ButtonComponent) -> Void in
                                        component.id = "\(restaurant.id)Address"
                                        component.title = restaurant.location.address
                                        component.height = 60.0
                                        component.insets = insets
                                        component.configuration = { (view: UIButton) -> Void in
                                            view.titleLabel?.numberOfLines = 0
                                        }
                                        component.onTap = { (_: UIButton) -> Void in
                                            s.openMaps(location: restaurant.location)
                                        }
                                }
                                componentsController.categoriesComponent {
                                    (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurant.id)Schedule"
                                        component.category = Category.time
                                        component.text = restaurant.schedule
                                }
                                componentsController.categoriesComponent {
                                    (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurant.id)Type"
                                        component.category = Category.type
                                        component.text = restaurant.type
                                }
                                componentsController.categoriesComponent {
                                    (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurant.id)Rating"
                                        component.category = Category.ratings
                                        component.ratings = restaurant.ratings
                                }
                                componentsController.categoriesComponent {
                                    (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurant.id)Menu"
                                        component.category = Category.menu
                                        component.text = restaurant.menuURL
                                        component.height = 120.0
                                }
                                componentsController.categoriesComponent {
                                    (component: inout CategoriesComponent) -> Void in
                                        component.id = "\(restaurant.id)Photos"
                                        component.category = Category.photos
                                        component.text = restaurant.photosURL
                                        component.height = 120.0
                                }
                            }
                        }

                        if state.restaurants.isEmpty == false && state.isLoading == false {
                            componentsController.buttonComponent { (component: inout ButtonComponent) -> Void in
                                component.id = "BUTTON"
                                component.title = "Load More"
                                component.onTap = { (_: UIButton) -> Void in
                                    s.getRestaurants()
                                }
                            }
                        }
                }
            }
        }
    }

    // MARK: Helper Functions
    @objc func librariesItemTapped() {
        self.delegate.goToAcknowledgements()
    }
}

// MARK: CLLocationManagerDelegate Methods
extension RestaurantListVC: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            self.viewModel.setState { (state: inout RestaurantListState) -> Void in
                state.currentLocation = locations.first
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
