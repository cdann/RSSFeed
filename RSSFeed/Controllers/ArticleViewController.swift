//
//  ArticleViewController.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate {

    var webView: WKWebView!
    var activityMonitor: UIActivityIndicatorView!
    var request: URLRequest?
    
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: view.frame)
        view = webView
        webView.scrollView.delegate = self
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
    
     // MARK: - Web view Navigation Delegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityMonitor!.stopAnimating()
        self.navigationController!.setNavigationBarHidden(true, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityMonitor!.stopAnimating()
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollY = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (scrollY.y > 0) {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

}
