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
            title: "Libraries",
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
    private func getRestaurants() {
//        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
//            guard let s = self else { return }
//            s.viewModel.getRestaurants(page: state.currentPage)
//        }
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

    public override func buildSections(_ sectionsController: inout MultiSectionController) { // swiftlint:disable:this function_body_length line_length
        Cyanic.withState(of: self.viewModel) { [weak self] (state: RestaurantListState) -> Void in
            sectionsController.sectionController { (sectionController: inout SectionController) -> Void in
                sectionController
                    .buildComponents { [weak self] (componentsController: inout ComponentsController) -> Void in
                    guard let s = self else { return }
                    componentsController.expandableComponent { (component: inout ExpandableComponent) -> Void in
                        let isExpanded = state.expandableDict["RESTAURANT 1"] == true
                        component.id = "RESTAURANT 1"
                        component.height = 60.0
                        component.isExpanded = isExpanded
                        component.insets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
                        component.setExpandableState = s.viewModel.setExpandableState
                        component.accessoryViewType = CommonWidgets.ChevronView.self
                        component.accessoryViewSize = CGSize(width: 15.0, height: 15.0)
                        component.dividerLine = DividerLine(
                            backgroundColor: UIColor.rsj.color(red: 229, green: 229, blue: 234),
                            insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0),
                            height: 1.0
                        )
                        component.contentLayout = LabelContentLayout(
                            text: Text.unattributed("MCDO"),
                            font: UIFont.boldSystemFont(ofSize: 17.0),
                            alignment: Alignment.centerLeading,
                            configuration: { (label: UILabel) -> Void in
                                label.textColor = UIColor.black
                            }
                        )
                        component.accessoryViewConfiguration = { (view: UIView) -> Void in
                            guard let view = view as? CommonWidgets.ChevronView else { return }
                            view.lineColor = UIColor.blue
                            switch isExpanded {
                                case true:
                                    view.direction = CommonWidgets.ChevronView.Direction.down
                                case false:
                                    view.direction = CommonWidgets.ChevronView.Direction.right
                            }
                        }
                    }

                    componentsController.expandableComponent { (component: inout ExpandableComponent) -> Void in
                        let isExpanded = state.expandableDict["RESTAURANT 2"] == true
                        component.id = "RESTAURANT 2"
                        component.height = 60.0
                        component.isExpanded = isExpanded
                        component.insets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
                        component.setExpandableState = s.viewModel.setExpandableState
                        component.accessoryViewType = CommonWidgets.ChevronView.self
                        component.accessoryViewSize = CGSize(width: 15.0, height: 15.0)
                        component.dividerLine = DividerLine(
                            backgroundColor: UIColor.rsj.color(red: 229, green: 229, blue: 234),
                            insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0),
                            height: 1.0
                        )
                        component.contentLayout = LabelContentLayout(
                            text: Text.unattributed("JOBEE"),
                            font: UIFont.boldSystemFont(ofSize: 17.0),
                            alignment: Alignment.centerLeading,
                            configuration: { (label: UILabel) -> Void in
                                label.textColor = UIColor.black
                            }
                        )
                        component.accessoryViewConfiguration = { (view: UIView) -> Void in
                            guard let view = view as? CommonWidgets.ChevronView else { return }
                            view.lineColor = UIColor.blue
                            switch isExpanded {
                                case true:
                                    view.direction = CommonWidgets.ChevronView.Direction.down
                                case false:
                                    view.direction = CommonWidgets.ChevronView.Direction.right
                            }
                        }
                    }

//                    state.restaurants.forEach { (restaurant: Restaurant) -> Void in
//                        let expandable: ExpandableComponent = componentsController
//                            .expandableComponent { (component: inout ExpandableComponent) -> Void in
//                                let id: String = restaurant.id
//                                let isExpanded: Bool = state.expandableDict[id] == true
//                                component.id = id
//                                component.height = 60.0
//                                component.isExpanded = isExpanded
//                                component.insets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
//                                component.setExpandableState = s.viewModel.setExpandableState
//                                component.accessoryViewType = CommonWidgets.ChevronView.self
//                                component.accessoryViewSize = CGSize(width: 15.0, height: 15.0)
//                                component.dividerLine = DividerLine(
//                                    backgroundColor: UIColor.rsj.color(red: 229, green: 229, blue: 234),
//                                    insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0),
//                                    height: 1.0
//                                )
//                                component.contentLayout = LabelContentLayout(
//                                    text: Text.unattributed(restaurant.name),
//                                    font: UIFont.boldSystemFont(ofSize: 17.0),
//                                    alignment: Alignment.centerLeading,
//                                    configuration: { (label: UILabel) -> Void in
//                                        label.textColor = UIColor.black
//                                    }
//                                )
//                                component.accessoryViewConfiguration = { (view: UIView) -> Void in
//                                    guard let view = view as? CommonWidgets.ChevronView else { return }
//                                    view.lineColor = UIColor.blue
//                                    switch isExpanded {
//                                        case true:
//                                            view.direction = CommonWidgets.ChevronView.Direction.down
//                                        case false:
//                                            view.direction = CommonWidgets.ChevronView.Direction.right
//                                    }
//                                }
//                        }
//
//                        if expandable.isExpanded {
//                            componentsController
//                                .imageHeaderComponent { (component: inout ImageHeaderComponent) -> Void in
//                                component.id = "IMAGEHEADER_\(restaurant.id)"
//                                component.imageURL = restaurant.featuredImage
//                            }
//                            componentsController
//                                .staticLabelComponent { (component: inout StaticLabelComponent) -> Void in
//                                component.id = "TEST_\(restaurant.id)"
//                                component.text = Text.unattributed(restaurant.menuURL)
//                                component.font = UIFont.boldSystemFont(ofSize: 17.0)
//                            }
//                        }
//                    }

                    if state.restaurants.isEmpty == false && state.isLoading == false {
                        componentsController.buttonComponent { (component: inout ButtonComponent) -> Void in
                            component.id = "BUTTON"
                            component.title = "Load More"
                            component.onTap = { [weak self] (_: UIButton) -> Void in
                                guard let s = self else { return }
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
