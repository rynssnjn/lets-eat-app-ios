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

public final class RestaurantListVC: MultiSectionTableComponentViewController {

    // MARK: Delegate Properties
    private weak var delegate: RestaurantListVCDelegate?

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
    private var currentLocation: CLLocation?

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
    private func getRestaurants() {
//        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
//            guard let s = self else { return }
//            s.viewModel.getRestaurants(page: state.currentPage).onComplete { (_) -> Void in }
//        }
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

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        switch scrollView.contentOffset.y > maximumOffset {
            case true:
                self.getRestaurants()
            case false:
                break
        }
    }

    public override func buildSections(_ sectionsController: inout MultiSectionController) {
        Cyanic.withState(of: self.viewModel) { (state: RestaurantListState) -> Void in
            sectionsController.sectionController { (sectionController: inout SectionController) -> Void in
                sectionController.buildComponents { (componentsController: inout ComponentsController) -> Void in
                    componentsController.restaurantComponent { (component: inout RestaurantComponent) -> Void in
                        let isExpanded = state.expandableDict["RESTAURANT 1"] == true
                        component.id = "RESTAURANT 1"
                        component.title = "MCDO"
                        component.isExpanded = isExpanded
                        component.setExpandableState = { [weak self] (id: String, isExpanded: Bool) -> Void in
                            guard let s = self else { return }
                            s.viewModel.setState { (state: inout RestaurantListState) -> Void in
                                state.expandableDict[id] = isExpanded
                            }
                        }
                    }
                    componentsController.restaurantComponent { (component: inout RestaurantComponent) -> Void in
                        let isExpanded = state.expandableDict["RESTAURANT 2"] == true
                        component.id = "RESTAURANT 2"
                        component.title = "JOBEE"
                        component.isExpanded = isExpanded
                        component.setExpandableState = { [weak self] (id: String, isExpanded: Bool) -> Void in
                            guard let s = self else { return }
                            s.viewModel.setState { (state: inout RestaurantListState) -> Void in
                                state.expandableDict[id] = isExpanded
                            }
                        }
                    }
//                    state.restaurants.forEach { (restaurant: Restaurant) -> Void in
//                        componentsController.restaurantComponent { (component: inout RestaurantComponent) -> Void in
//                            let isExpanded = state.expandableDict[restaurant.id] == true
//                            component.id = restaurant.id
//                            component.title = restaurant.name
//                            component.isExpanded = isExpanded
//                            component.setExpandableState = { [weak self] (id: String, isExpanded: Bool) -> Void in
//                                guard let s = self else { return }
//                                s.viewModel.setState { (state: inout RestaurantListState) -> Void in
//                                    state.expandableDict[id] = isExpanded
//                                }
//                            }
//                        }
//                    }
                }
            }
        }
    }
}

// MARK: CLLocationManagerDelegate Methods
extension RestaurantListVC: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            if self.currentLocation == nil {
                self.currentLocation = locations.first
                print(currentLocation?.coordinate) // for testing only
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
