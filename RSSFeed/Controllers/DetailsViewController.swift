//
//  DetailsViewController.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    let toArticleViewSegueIdentifier = "toArticleView"
    
    var rssFeedItem: FeedItem?
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDate: UILabel!
    @IBOutlet weak var itemAuthor: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemLink: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewLabels()
    }
    
    private func setUpViewLabels() {
        guard let item = self.rssFeedItem, isViewLoaded else {
            return
        }
        self.itemTitle.text = item.title
        self.itemDate.text = item.date
        self.itemAuthor.text = item.author
        self.itemDescription.text = item.descriptionString
        self.itemLink.isHidden = item.link == nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let articleCtrl = segue.destination as? ArticleViewController,
            let url = URL(string: self.rssFeedItem?.link ?? "") {
            let request = URLRequest(url: url)
            articleCtrl.request = request
            
        }
    }
    
    
    
}
