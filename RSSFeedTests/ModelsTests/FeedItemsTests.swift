//
//  FeedItemsTests.swift
//  RSSFeedTests
//
//  Created by celine dann on 13/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import XCTest
import FeedKit
@testable import RSSFeed

class FeedItemsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        FeedItem.formater.dateFormat = "dd MMM yyyy"
    }

    func testFeedItem() {
        let dateString = "03 Aug 2019"
        let date = FeedItem.formater.date(from: "03 Aug 2019")
        let item = RSSFeedItem()
        item.author = "author"
        item.title = "pop"
        item.link = "link"
        item.description = "description"
        item.pubDate = date
        var feedItem = FeedItem(item: item)
        XCTAssert(feedItem?.author == "author")
        XCTAssert(feedItem?.title == "pop")
        XCTAssert(feedItem?.link == "link")
        XCTAssert(feedItem?.description == "description")
        XCTAssert(feedItem?.pubDate == date)
        XCTAssert(feedItem?.date == dateString)
        item.title = nil
        feedItem = FeedItem(item: item)
        XCTAssert(feedItem == nil)
    }

}
