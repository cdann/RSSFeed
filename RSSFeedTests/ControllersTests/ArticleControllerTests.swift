//
//  ArticleControllerTests.swift
//  RSSFeedTests
//
//  Created by celine dann on 13/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import XCTest
import WebKit
@testable import RSSFeed

class ArticleControllerTests: XCTestCase {
    var vcArticle: ArticleViewController!

    override func setUp() {
        super.setUp()
        vcArticle = ArticleViewController()
        let _ = vcArticle
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testView() {
        let webview = vcArticle.view as? WKWebView
        XCTAssertTrue(webview != nil, "ArticleView isn't a webView")
        XCTAssertTrue(webview?.navigationDelegate as? ArticleViewController == vcArticle, "ArticleController isn't the delegate of the webview")
        let activityIndicator = webview?.subviews.last as? UIActivityIndicatorView
        XCTAssertTrue(activityIndicator != nil, "ArticleView doesn't contain a activity indicator")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
