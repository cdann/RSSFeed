//
//  ArticleViewController.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var activityMonitor: UIActivityIndicatorView!
    var request: URLRequest?
    
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: view.frame)
        view = webView
        activityMonitor = UIActivityIndicatorView(style: .gray)
        activityMonitor.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityMonitor)
        activityMonitor.startAnimating()
        let xCenterConstraint = NSLayoutConstraint(item: activityMonitor!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: activityMonitor!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        xCenterConstraint.isActive = true
        yCenterConstraint.isActive = true
        webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let req = self.request {
            webView.load(req)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityMonitor!.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityMonitor!.stopAnimating()
    }

}
