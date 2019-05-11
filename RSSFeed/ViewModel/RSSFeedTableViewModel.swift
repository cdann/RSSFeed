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
    func loadFeed(changeAfterDataLoaded: @escaping () -> (), handleError: @escaping (Error) -> ())
}

class FeedFromRSSFeedManagerTableViewModel: RSSFeedTableViewModel {
    var feedItems: [FeedItem] = []
    let feedManager: FeedManager
    
    init(feedManager: FeedManager) {
        self.feedManager = feedManager
    }
    
    func loadFeed(changeAfterDataLoaded: @escaping () -> (), handleError: @escaping (Error) -> ()) {
        feedManager.getFeeds() {
            [weak self] resultItems in
            DispatchQueue.main.async {
                switch resultItems{
                case let .success(items):
                    self?.feedItems = items
                    changeAfterDataLoaded()
                case let .failure(error):
                    handleError(error)
                }
            }
        }
    }

}
