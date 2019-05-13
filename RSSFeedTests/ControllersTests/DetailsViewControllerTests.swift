//
//  DetailsViewControllerTests.swift
//  RSSFeedTests
//
//  Created by celine dann on 11/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import XCTest
@testable import RSSFeed

class DetailsViewControllerTests: XCTestCase {
    var vcDetail: DetailsViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vcDetail = vc
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetUpViewLabels() {
        let date = Date()
        let item = FeedItem(title: "titre", author: "auteur", pubDate: date, description: nil, link: "youpyoup", content: nil)
        vcDetail.rssFeedItem = item
        let _ = vcDetail.view
        XCTAssert(vcDetail.itemTitle.text == "titre")
        XCTAssert(vcDetail.itemDate.text == "\(item.date) -- auteur")
        XCTAssert(vcDetail.itemContent.isHidden == true)
    }

}
