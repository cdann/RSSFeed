//
//  RSSFeedTableViewModelTest.swift
//  RSSFeedTests
//
//  Created by celine dann on 13/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import XCTest
@testable import RSSFeed

class TestFeedManager: FeedManager {
    enum TestError: Error{
        case noResultSet
    }
    var feedResult: FeedResult?

    func getFeeds(onCompletion: @escaping (FeedResult) -> ()) {
        guard let result = feedResult else {
            onCompletion(FeedResult.failure(TestError.noResultSet))
            return
        }
        onCompletion(result)
    }
}

class FeedFromRSSFeedManagerTableViewModelTest: XCTestCase {
    var modelView: FeedFromRSSFeedManagerTableViewModel!
    var testFeedManager = TestFeedManager()
    
    typealias MVResult = Result<(), Error>

    override func setUp() {
        modelView = FeedFromRSSFeedManagerTableViewModel(feedManager: testFeedManager)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadFeedWorks() {
        let items = Array(repeating: FeedItem(title: ""), count: 3)
        testFeedManager.feedResult = Result.success(items)
        var expectation = self.expectation(description: "loadFeed")
        var feedItems: [FeedItem]? = nil
        modelView.loadFeed { [weak self] (result) in
            feedItems = self?.modelView.feedItems
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(feedItems != nil && feedItems! == items, "modelView feedItems aren't the ones expected")
    }
    
    func testLoadFeedError() {
        let expectation = self.expectation(description: "loadFeed")
        var feedItems: [FeedItem]? = nil
        var feedResult: MVResult? = nil
        modelView.loadFeed { [weak self] (result) in
            feedItems = self?.modelView.feedItems
            feedResult = result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(feedItems?.count == 0, "feedItems should be nil")
        switch feedResult!{
        case Result.success():
            XCTFail("result should be an error")
        case let Result.failure(error):
            XCTAssert(type(of: error) == TestFeedManager.TestError.self)
        }
    }

}
