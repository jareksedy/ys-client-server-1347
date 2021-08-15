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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let infoCell = tableView.dequeueReusableCell(withIdentifier: "feedItemInfoCell", for: indexPath) as! FeedItemInfoTableViewCell
        
        let currentFeedItem = feedItems[indexPath.section]
        
        switch feedItems[indexPath.section].sourceID.signum() {
        
        case 1: // Пост пользователя
            let currentFeedItemProfile = feedProfiles.filter{ $0.id == currentFeedItem.sourceID }[0]
            infoCell.configure(profile: currentFeedItemProfile, postDate: currentFeedItem.date)
            
        case -1: // Пост группы
            let currentFeedItemGroup = feedGroups.filter{ $0.id == abs(currentFeedItem.sourceID) }[0]
            infoCell.configure(group: currentFeedItemGroup, postDate: currentFeedItem.date)
            
        default: break
        }
        
        return infoCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return feedItems[section].date.getDateStringFromUTC()
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
