//
//  FriendsTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 27.08.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    private let api = FriendAPI()
    private let viewModelFactory = FriendViewModelFactory()
    private var viewModels: [FriendViewModel] = []
    var friendItems: [FriendItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.separatorStyle = .none
        
        refresh(sender: self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendsTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(with: viewModels[indexPath.row])
        cell.parentVC = self
        cell.delegate = self
        return cell
    }
    
    // MARK: - Refresh table.
    @objc func refresh(sender:AnyObject) {
        
        api.get { [weak self] friends in
            guard let self = self else { return }
            self.friendItems = friends!.response.items
            self.viewModels = self.viewModelFactory.constructViewModels(from: self.friendItems)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}

extension FriendsTableViewController: CellUpdater {
    
    func updateTableView() {
        refresh(sender: self)
    }
}
