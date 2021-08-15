//
//  FeedTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.08.2021.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    var feedItems: [Item] = []
    var feedProfiles: [Profile] = []
    var feedGroups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedAPI(Session.instance).get{ [weak self] feed in
            guard let self = self else { return }
            self.feedItems = feed!.response.items
            self.feedProfiles = feed!.response.profiles
            self.feedGroups = feed!.response.groups
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return feedItems.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return feedInfoCell(indexPath: indexPath)
            
        case 1:
            return feedTextCell(indexPath: indexPath)
            
        default:
            return feedInfoCell(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return feedItems[section].date.getDateStringFromUTC()
    }

    // MARK: - Create & configure cells.
    
    // MARK: - Feed item author, date & image.
    func feedInfoCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemInfoCell", for: indexPath) as! FeedItemInfoTableViewCell
        let currentFeedItem = feedItems[indexPath.section]
        
        switch feedItems[indexPath.section].sourceID.signum() {
        
        case 1: // Пост пользователя
            let currentFeedItemProfile = feedProfiles.filter{ $0.id == currentFeedItem.sourceID }[0]
            cell.configure(profile: currentFeedItemProfile, postDate: currentFeedItem.date)
            
        case -1: // Пост группы
            let currentFeedItemGroup = feedGroups.filter{ $0.id == abs(currentFeedItem.sourceID) }[0]
            cell.configure(group: currentFeedItemGroup, postDate: currentFeedItem.date)
            
        default: break
        }
        
        return cell
    }
    
    // MARK: - Feed item text.
    func feedTextCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemTextCell", for: indexPath) as! FeedItemTextTableViewCell
        let currentFeedItem = feedItems[indexPath.section]
        cell.configure(text: currentFeedItem.text)
        
        return cell
        
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}
