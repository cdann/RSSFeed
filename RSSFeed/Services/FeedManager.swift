//
//  FeedManager.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation
import FeedKit

typealias FeedResult = Swift.Result<[FeedItem], Error>

protocol FeedManager {
    func getFeeds(onCompletion: @escaping (FeedResult) -> ())
}

class RSSFeedManager: FeedManager{
    let feedUrl = URL(string: "https://medium.com/feed/@medium")!
    
    enum RSSError: Error {
        case unexpectedDataFormat
        case unhandledFormatFeed
        case feedManagerNil
    }
    
    func getFeeds(onCompletion: @escaping (FeedResult) -> ()){
        let parser = FeedParser(URL: feedUrl)
        parser.parseAsync { [weak self] (result) in
            switch result {
            case let Result.failure(error):
                onCompletion(FeedResult.failure(error))
            case let Result.rss(feed):
                let feedResult = self?.rssToFeedItems(rss: feed)
                let error = FeedResult.failure(RSSError.feedManagerNil)
                onCompletion(feedResult ?? error)
            default:
                onCompletion(FeedResult.failure(RSSError.unhandledFormatFeed))
            }
        }
    }
    
    private func rssToFeedItems(rss: RSSFeed) -> FeedResult {
        guard let items = rss.items else {
            return FeedResult.failure(RSSError.unexpectedDataFormat)
        }
        let feedItems = items.compactMap { (item) -> FeedItem? in
            return FeedItem(item: item)
        }
        if items.count != feedItems.count {
            return FeedResult.failure(RSSError.unexpectedDataFormat)
        }
        return FeedResult.success(feedItems)
    }
}
