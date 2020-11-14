//
//  RestaurantWebVC.swift
//  lets-eat-app-ios
//
//  Created by Rael San Juan on 11/14/20.
//

import Foundation
import RSJ
import WebKit

public final class RestaurantWebVC: RSJViewController {

    // MARK: Delegate Properties
    private unowned let delegate: RestaurantWebVCDelegate

    // MARK: Initializer
    public init(delegate: RestaurantWebVCDelegate, webURL: String) {
        self.delegate = delegate
        self.webURL = webURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Stored Properties
    private let webURL: String

    // MARK: LifeCycle Methods
    public override func loadView() {
        let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
        configuration.dataDetectorTypes = WKDataDetectorTypes.all
        self.view = WKWebView(frame: CGRect.zero, configuration: configuration)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        if let url: URL = URL(string: self.webURL) {
            self.webView.load(URLRequest(url: url))
        }

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "back".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(RestaurantWebVC.backButtonItemTapped)
        )
    }

    // MARK: Helper Methods
    @objc func backButtonItemTapped() {
        self.delegate.backButtonItemTapped()
    }
}

// MARK: Views
private extension RestaurantWebVC {
    private unowned var webView: WKWebView { return self.view as! WKWebView } // swiftlint:disable:this force_cast
}
