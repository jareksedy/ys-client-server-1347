//
//  GroupTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    var groupItems: [GroupItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GroupAPI(Session.instance).get{ groups in
            
            guard let groups = groups else { return }
            self.groupItems = groups.response.items
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupTableViewCell else { return UITableViewCell() }
        
        cell.configure(groupItems[indexPath.row])

        return cell
    }
}
