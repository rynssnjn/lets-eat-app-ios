//
//  ReviewsVC.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/15/20.
//

import Foundation
import RxSwift
import RxDataSources
import Cyanic
import LayoutKit

public final class ReviewsVC: MultiSectionTableComponentViewController {

    // MARK: Delegate Properties
    private unowned let delegate: ReviewsVCDelegate

    // MARK: Initializer
    public init(delegate: ReviewsVCDelegate, restaurant: Restaurant) {
        self.delegate = delegate
        let state: ReviewsState = ReviewsState.default
            .copy { (state: inout ReviewsState) -> Void in
                state.restaurant = restaurant
        }

        self.viewModel = ReviewsVM(initialState: state)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Stored Properties
    private let viewModel: ReviewsVM

    // MARK: Computed Properties
    public override var viewModels: [AnyViewModel] {
        return [
            self.viewModel.asAnyViewModel
        ]
    }

    private var computedHeight: CGFloat {
        return UIScreen.main.bounds.height * 0.8
    }

    // MARK: LifeCycle Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "back".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(ReviewsVC.backButtonItemTapped)
        )

        self.viewModel.getReviews()
    }

    // MARK: Instance Methods
    public override func invalidate() {
        Cyanic.withState(of: self.viewModel) { [weak self] (state: ReviewsState) -> Void in
            guard let s = self else { return }
            state.isLoading && state.reviews.isEmpty ? s.rsj.showActivityIndicator() : s.rsj.hideActivityIndicator()
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

    public override func buildSections(_ sectionsController: inout MultiSectionController) { // swiftlint:disable:this function_body_length
        Cyanic.withState(of: self.viewModel) { (state: ReviewsState) -> Void in
            sectionsController.sectionController { [weak self] (sectionController: inout SectionController) -> Void in
                guard let s = self, let restaurant = state.restaurant else { return }
                if state.reviews.isEmpty && state.isLoading == false {
                    sectionController.errorMessageComponent(for: SectionController.SupplementaryView.header) {
                        (component: inout ErrorMessageComponent) -> Void in
                        component.id = "ErrorMessage"
                        component.height = s.computedHeight
                        component.errorMessage = "no_reviews".localized.replacingOccurrences(of: "%s", with: restaurant.name)
                    }
                } else {
                    sectionController.staticLabelComponent(for: SectionController.SupplementaryView.header) {
                        (component: inout StaticLabelComponent) -> Void in
                        component.id = "ReviewsTitle"
                        component.backgroundColor = UIColor.white
                        component.text = Text.unattributed("reviews".localized)
                        component.font = UIFont.boldSystemFont(ofSize: 25.0)
                        component.alignment = Alignment.centerLeading
                        component.configuration = { (view: UILabel) -> Void in
                            view.textColor = UIColor.black
                        }
                        component.insets = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 15.0)
                    }

                    sectionController.buildComponents { (componentsController: inout ComponentsController) -> Void in
                        state.reviews.forEach { (review: Review) -> Void in
                            componentsController.userReviewComponent { (component: inout UserReviewComponent) -> Void in
                                component.id = "\(review.id)UserReview"
                                component.height = 60.0
                                component.reviewer = review.reviewer
                                component.rating = review.rating
                                component.onTap = { () -> Void in
                                    s.delegate.viewProfile(profile: review.reviewer.profileURL)
                                }
                            }

                            componentsController.staticLabelComponent { (component: inout StaticLabelComponent) -> Void in
                                component.id = "\(review.id)Comment"
                                component.text = Text.unattributed(review.comment)
                                component.font = UIFont.systemFont(ofSize: 17.0)
                                component.insets = EdgeInsets(top: 5.0, left: 20.0, bottom: 10.0, right: 15.0)
                            }

                            componentsController.staticLabelComponent { (component: inout StaticLabelComponent) -> Void in
                                component.id = "\(review.id)Date"
                                component.text = Text.unattributed("\("commented".localized): \(review.date)")
                                component.font = UIFont.systemFont(ofSize: 15.0)
                                component.insets = EdgeInsets(top: 5.0, left: 20.0, bottom: 10.0, right: 15.0)
                            }

                            componentsController.sizedComponent { (component: inout SizedComponent) -> Void in
                                component.id = "\(review.id)Divider"
                                component.height = 1.0
                                component.backgroundColor = UIColor.rsj.color(red: 229, green: 229, blue: 234)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: Target Action Functions
    @objc func backButtonItemTapped() {
        self.delegate.backButtonItemTapped()
    }
}
