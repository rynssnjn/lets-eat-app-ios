//
//  AcknowledgementsVC.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/8/20.
//

import Foundation
import RxSwift
import RxDataSources
import Cyanic
import LayoutKit
import CommonWidgets

public final class AcknowledgementsVC: MultiSectionTableComponentViewController {

    // MARK: Delegate Properties
    private unowned let delegate: AcknowledgementsVCDelegate

    // MARK: Initializers
    public init(delegate: AcknowledgementsVCDelegate, acknowledgements: [Acknowledgement]) {
        self.delegate = delegate
        let state: AcknowledgementsState = AcknowledgementsState.default
            .copy { (state: inout AcknowledgementsState) -> Void in
                state.acknowledgements = acknowledgements
            }
        self.viewModel = AcknowledmentsVM(initialState: state)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Stored Properties
    private let viewModel: AcknowledmentsVM

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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "back".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(AcknowledgementsVC.backButtonItemTapped)
        )
    }

    // MARK: Instance Methods
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
        Cyanic.withState(of: self.viewModel) { (state: AcknowledgementsState) -> Void in
            sectionsController.sectionController { (sectionController: inout SectionController) -> Void in
                sectionController.staticLabelComponent(for: SectionController.SupplementaryView.header) {
                    (component: inout StaticLabelComponent) -> Void in
                    component.id = "Title"
                    component.text = Text.unattributed("disclaimer".localized)
                    component.backgroundColor = UIColor.white
                    component.font = UIFont.boldSystemFont(ofSize: 25.0)
                    component.alignment = Alignment.centerLeading
                    component.configuration = { (view: UILabel) -> Void in
                        view.textColor = UIColor.black
                    }
                    component.insets = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 15.0)
                }

                sectionController.buildComponents { [weak self] (componentsController: inout ComponentsController) -> Void in
                    guard let s = self else { return }
                    state.acknowledgements.forEach { (acknowledgement: Acknowledgement) -> Void in
                        let expandable: ExpandableComponent = componentsController
                            .expandableComponent { (component: inout ExpandableComponent) -> Void in
                                let id: String = "\(acknowledgement.title)Title"
                                let isExpanded: Bool = state.expandableDict[id] == true
                                component.id = id
                                component.height = 60.0
                                component.isExpanded = isExpanded
                                component.insets = EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 15.0)
                                component.setExpandableState = s.viewModel.setExpandableState
                                component.accessoryViewType = ChevronView.self
                                component.accessoryViewSize = CGSize(width: 15.0, height: 15.0)
                                component.dividerLine = DividerLine(
                                    backgroundColor: UIColor.rsj.color(red: 229, green: 229, blue: 234),
                                    insets: EdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0),
                                    height: 1.0
                                )

                                component.contentLayout = LabelContentLayout(
                                    text: Text.unattributed(acknowledgement.title),
                                    font: UIFont.boldSystemFont(ofSize: 17.0),
                                    alignment: Alignment.centerLeading,
                                    configuration: { (label: UILabel) -> Void in
                                        label.textColor = UIColor.black
                                    }
                                )

                                component.accessoryViewConfiguration = { (view: UIView) -> Void in
                                    guard let view = view as? ChevronView else { return }
                                    view.lineColor = UIColor.blue
                                    switch isExpanded {
                                        case true:
                                            view.direction = ChevronView.Direction.down
                                        case false:
                                            view.direction = ChevronView.Direction.right
                                    }
                                }
                        }

                        if expandable.isExpanded {
                            componentsController.staticTextComponent { (component: inout StaticTextComponent) -> Void in
                                component.id = "\(acknowledgement.title)Content"
                                component.text = Text.unattributed(acknowledgement.content)
                                component.font = UIFont.systemFont(ofSize: 17.0)
                                component.configuration = { (textView: UITextView) -> Void in
                                    textView.textColor = UIColor.black
                                    textView.isEditable = false
                                    textView.dataDetectorTypes = UIDataDetectorTypes.link
                                    textView.linkTextAttributes = [
                                        NSAttributedString.Key.foregroundColor: UIColor.blue,
                                        NSAttributedString.Key.underlineStyle: 1,
                                        NSAttributedString.Key.underlineColor: UIColor.blue
                                    ]
                                }
                                component.insets = EdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: Helper Methods
    @objc func backButtonItemTapped() {
        self.delegate.backButtonItemTapped()
    }
}
