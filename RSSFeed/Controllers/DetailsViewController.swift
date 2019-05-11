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
    let toArticleViewSegueIdentifier = "toArticleView"
    
    var rssFeedItem: FeedItem?
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var itemContent: WKWebView!
    var urlRequest: URLRequest? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewLabels()
        itemContent.navigationDelegate = self
        
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let articleCtrl = segue.destination as? ArticleViewController {
            if urlRequest == nil {
                let url = URL(string: self.rssFeedItem?.link ?? "")
                urlRequest = url != nil ? URLRequest(url: url!) : nil
            }
            articleCtrl.request = urlRequest
            urlRequest = nil
        }
    }
    
    // MARK: - Web view Navigation Delegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            self.urlRequest = navigationAction.request
            performSegue(withIdentifier: toArticleViewSegueIdentifier, sender: nil)
        }
        decisionHandler(WKNavigationActionPolicy.cancel)
    }
    
}
