//
//  RSSFeedTableViewController.swift
//  RSSFeed
//
//  Created by celine dann on 09/05/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit

class RSSFeedTableViewController: UITableViewController {
    let cellIdentifier = "rssCell"
    let toDetailViewSegueIdentifier = "toDetailsView"
    
    var viewModel: RSSFeedTableViewModel?
    var selectedItem: FeedItem?
    
    override func loadView() {
        super.loadView()
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(RSSFeedTableViewController.loadFeed), for: .valueChanged)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FeedFromRSSFeedManagerTableViewModel(feedManager: RSSFeedManager())
        loadFeed()
    }
    
    /* calls the viewModel to load the feed */
    @objc func loadFeed() {
        viewModel!.loadFeed { [weak self] (result) in
            if case let Result.failure(error) = result {
                self?.alertError(error: error)
            } else {
                self?.tableView.reloadData()
            }
            self?.refreshControl?.endRefreshing()
        }
    }
    
    func alertError(error: Error) {
        let alertController = UIAlertController(title: "Oops ❗️", message: "Veuillez rééssayer plus tard. Erreur: \(error) ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.feedItems.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = self.viewModel?.feedItems[indexPath.row]
        cell.textLabel?.text = item?.title
        cell.detailTextLabel?.text = item?.date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem = self.viewModel?.feedItems[indexPath.row]
        self.performSegue(withIdentifier: toDetailViewSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let nextCtrl = segue.destination as? DetailsViewController {
            nextCtrl.rssFeedItem = selectedItem
            self.selectedItem = nil
        }
    }


}
