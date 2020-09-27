//
//  BreedsDetailViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/26/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit
import WebKit

class BreedDetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet fileprivate var webView: WKWebView!
    var breed: BreedModel?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = breed?.wikiURL else { return }
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        view.showLoader()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.hideLoader()
    }
}
