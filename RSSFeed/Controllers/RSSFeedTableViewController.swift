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
    var activityMonitor: UIActivityIndicatorView?
    
    override func loadView() {
        super.loadView()
        activityMonitor = UIActivityIndicatorView()
        tableView.addSubview(activityMonitor!)
        activityMonitor!.startAnimating()
        activityMonitor!.style = .gray
        activityMonitor!.hidesWhenStopped = true
        activityMonitor!.translatesAutoresizingMaskIntoConstraints = false
        let xCenterConstraint = NSLayoutConstraint(item: activityMonitor!, attribute: .centerX, relatedBy: .equal, toItem: tableView, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: activityMonitor!, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .top, multiplier: 1, constant: 50)
        xCenterConstraint.isActive = true
        yCenterConstraint.isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RSSFeedFromFeedManagerTableViewModel(feedManager: RSSFeedManager())
        loadFeed()
    }
    
    func loadFeed() {
        let afterChanges: () -> () = { [weak self] in
            self?.tableView.reloadData()
            self?.activityMonitor?.stopAnimating()
        }
        self.activityMonitor?.startAnimating()
        viewModel!.loadFeed(changeAfterDataLoaded: afterChanges, handleError: alertError(error:))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.feedItems.count ?? 0
    }
    
    func alertError(error: Error) {
        self.activityMonitor?.stopAnimating()
        let alertController = UIAlertController(title: "Oops ❗️", message: "Veuillez rééssayer plus tard. Erreur: \(error) ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
