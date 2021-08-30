//
//  FeedTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.08.2021.
//

import UIKit
import Alamofire

class FeedTableViewController: UITableViewController {
    
    var feedItems: [Item] = []
    var feedProfiles: [Profile] = []
    var feedGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.register(FeedItemFooter.self, forHeaderFooterViewReuseIdentifier: "sectionFooter")
        tableView.sectionFooterHeight = 50
        tableView.separatorStyle = .singleLine
        
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
        
        let currentFeedItem = feedItems[section]
        var count = 1
        
        if currentFeedItem.hasText { count += 1 }
        if currentFeedItem.hasPhoto604 { count += 1 }
        if currentFeedItem.hasLink { count += 1}
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentFeedItem = feedItems[indexPath.section]
        
        switch indexPath.row {
        
        case 0:
            return feedInfoCell(indexPath: indexPath)
            
        case 1:
            return currentFeedItem.hasText ? feedTextCell(indexPath: indexPath) : feedPhotoCell(indexPath: indexPath)
            
        case 2:
            return currentFeedItem.hasLink ? feedLinkCell(indexPath: indexPath) : feedPhotoCell(indexPath: indexPath)
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - Open link on cell tap.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = feedItems[indexPath.section].attachments?[0].link?.url else { return }
        UIApplication.shared.open(URL(string: url)!)
    }
    
    // MARK: - Configure footer.
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionFooter") as! FeedItemFooter
        let currentFeedItem = feedItems[section]
        
        view.likeButton.configure(likesCount: currentFeedItem.likes.count,
                                  isLikedByMe: currentFeedItem.likes.userLikes == 1 ? true : false,
                                  itemID: currentFeedItem.postID ?? 0,
                                  ownerID: currentFeedItem.sourceID,
                                  completionHandlerLiked: {
                                    self.feedItems[section].likes.count += 1
                                    self.feedItems[section].likes.userLikes = 1
                                  },
                                  completionHandlerUnLiked: {
                                    self.feedItems[section].likes.count -= 1
                                    self.feedItems[section].likes.userLikes = 0
                                  })
        
        // --[ ⚑ ]--
        
        var footerText = ""
        
        footerText += (currentFeedItem.views?.count ?? 0) > 0 ? "⊹ \(Int(currentFeedItem.views!.count).formatted)" : ""
        footerText += currentFeedItem.reposts.count > 0 ? "   |   ⌁ \(Int(currentFeedItem.reposts.count).formatted)" : ""
        footerText += currentFeedItem.comments.count > 0 ? "   |   ℘ \(Int(currentFeedItem.comments.count).formatted)" : ""
        
        view.postInfo.text = footerText
        
        return view
    }
    
    // MARK: - Create & configure cells.
    
    // MARK: - Feed item author, date & image.
    
    func feedInfoCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemInfoCell", for: indexPath) as! FeedItemInfoTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
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
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentFeedItem = feedItems[indexPath.section]
        
        if currentFeedItem.hasText {
            
            cell.configure(text: currentFeedItem.text)
            return cell
            
        } else { return UITableViewCell() }
    }
    
    // MARK: - Feed item link.
    
    func feedLinkCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemLinkCell", for: indexPath) as! FeedItemLinkCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentFeedItem = feedItems[indexPath.section]
        
        if currentFeedItem.hasLink {
            
            cell.configure(link: currentFeedItem.attachments![0].link!)
            return cell
            
        } else { return UITableViewCell() }
    }
    
    // MARK: - Feed item photo.
    
    func feedPhotoCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedItemPhotoCell", for: indexPath) as! FeedItemPhotoTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let currentFeedItem = feedItems[indexPath.section]
        
        if currentFeedItem.hasPhoto604 {
            
            cell.configure(url: currentFeedItem.attachments![0].photo!.photo604!)
            return cell
            
        } else {
            
            return UITableViewCell()
            
        }
    }
    
    // MARK: - Refresh table.
    
    @objc func refresh(sender:AnyObject)
    {
        FeedAPI(Session.instance).get{ [weak self] feed in
            guard let self = self else { return }
            self.feedItems = feed!.response.items
            self.feedProfiles = feed!.response.profiles
            self.feedGroups = feed!.response.groups
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
}
