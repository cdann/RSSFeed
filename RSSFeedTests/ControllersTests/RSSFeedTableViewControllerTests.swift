//
//  RSSFeedTableViewControllerTests.swift
//  RSSFeedTests
//
//  Created by celine dann on 11/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import XCTest
@testable import RSSFeed

class TestRSSFeedTableViewModel: RSSFeedTableViewModel {
    var feedItems: [FeedItem] = []
    var loadFeedCalled: Bool = false
    
    
    func loadFeed(handleAfterRequest: @escaping (Result<(), Error>) -> ()) {
        self.loadFeedCalled = true
    }
}

class RSSFeedTableViewControllerTests: XCTestCase {
    var vcRSS: RSSFeedTableViewController!
    var testViewModel = TestRSSFeedTableViewModel()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RSSFeedTableViewController") as! RSSFeedTableViewController
        vcRSS = vc
        let _ = vc.view
        vc.viewModel = testViewModel
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testLoadFeed() {
        vcRSS.loadFeed()
        XCTAssert(testViewModel.loadFeedCalled, "loadFeed hasn't been called")
    }
    
    func testTableView() {
        testViewModel.feedItems = Array(repeating: FeedItem(title: "item"), count: 4)
        XCTAssert(vcRSS.tableView.numberOfRows(inSection: 0) == 4)
    }
}
