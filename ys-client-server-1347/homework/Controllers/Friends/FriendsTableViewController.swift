//
//  FriendsTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 27.08.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friendItems: [FriendItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.separatorStyle = .none
        
        FriendAPI(Session.instance).get{ [weak self] friends in
            guard let self = self else { return }
            self.friendItems = friends!.response.items
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendsTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(friendItems[indexPath.row])
        return cell
    }
    
    // MARK: - Refresh table.
    @objc func refresh(sender:AnyObject)
    {
        FriendAPI(Session.instance).get{ [weak self] friends in
            guard let self = self else { return }
            self.friendItems = friends!.response.items
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}
