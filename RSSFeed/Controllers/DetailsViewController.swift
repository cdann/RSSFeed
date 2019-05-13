//
//  DetailsViewController.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {
    
    var rssFeedItem: FeedItem?
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var itemContent: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewLabels()
        itemContent.navigationDelegate = self
    }
    
    /* fills the labels and the webview with the content of the item*/
    private func setUpViewLabels() {
        guard let item = self.rssFeedItem, isViewLoaded else {
            return
        }
        self.itemTitle.text = item.title
        self.itemDate.text = item.author != nil ? "\(item.date) -- \(item.author!)" : item.date
        self.itemContent.isHidden = item.content == nil && item.description == nil
        let css = """
        <style>
            body {
                font-size: 2em
            }
            a {
                color: #F08A4B
            }
            img {
                height: auto;
                width: 100%;
            }
        </style>
        """
        if let content = item.content ?? item.description {
            self.itemContent.loadHTMLString("\(css)\(content)", baseURL: nil)
        }
    }
    
    // MARK: - Navigation to ArticleViewController
    
    /* initializes a fullWebView Controller ArticleViewController when a link is clicked */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            let urlRequest = navigationAction.request
            decisionHandler(WKNavigationActionPolicy.cancel)
            self.initArticleViewCtrl(urlRequest: urlRequest)
            return
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    /*initializes a view controller to see the full article in ArticleViewController*/
    @IBAction func seeSource(_ sender: Any) {
        let url = URL(string: self.rssFeedItem?.link ?? "")
        let request = url != nil ? URLRequest(url: url!) : nil
        self.initArticleViewCtrl(urlRequest: request)
    }
    
    private func initArticleViewCtrl(urlRequest: URLRequest?) {
        let viewController = ArticleViewController()
        viewController.request = urlRequest
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
