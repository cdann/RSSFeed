//
//  RSSFeedTableViewModel.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation

protocol RSSFeedTableViewModel {
    var feedItems: [FeedItem] { get }
    func loadFeed(handleAfterRequest: @escaping (Result<(), Error>) -> ())
}

class FeedFromRSSFeedManagerTableViewModel: RSSFeedTableViewModel {
    var feedItems: [FeedItem] = []
    let feedManager: FeedManager
    
    init(feedManager: FeedManager) {
        self.feedManager = feedManager
    }
    
    func loadFeed(handleAfterRequest: @escaping (Result<(), Error>) -> ()) {
        feedManager.getFeeds() {
            [weak self] resultItems in
            DispatchQueue.main.async {
                let result = resultItems.map({ (items) -> () in
                    self?.feedItems = items
                })
                handleAfterRequest(result)
            }
        }
    }

}
