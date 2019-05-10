//
//  FeedItem.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation
import FeedKit

class FeedItem {
    static let formater = DateFormatter()
    let title: String
    let author: String?
    let pubDate: Date
    let description: String?
    let link: String?
    
    var date: String {
        get {
            FeedItem.formater.dateFormat = "dd MMM yyyy"
            return FeedItem.formater.string(from: pubDate)
        }
    }
    
    var descriptionString: String? {
        get {
            guard let description = self.description else { return nil }
            return description.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        }
    }
    
    init(title: String, author: String?, pubDate: Date, description: String?, link: String?) {
        self.title = title
        self.author = author
        self.pubDate = pubDate
        self.description = description
        self.link = link
    }
    
    convenience init?(item: RSSFeedItem) {
        guard let title = item.title,
            let date = item.pubDate
            else {
                return nil
        }
        self.init(title: title, author: item.author, pubDate: date, description: item.description, link: item.link)
    }
}
