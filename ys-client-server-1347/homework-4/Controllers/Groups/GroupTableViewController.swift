//
//  GroupTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import RealmSwift

class GroupTableViewController: UITableViewController {
    
    var groupItems: [GroupItem] = []
    let groupDB = GroupDB()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localGroupsResults = groupDB.get()
        
        token = localGroupsResults.observe { (changes: RealmCollectionChange) in
            
            switch changes {
            
            case .initial(let results):
                self.groupItems = Array(results)
                self.tableView.reloadData()
                
            case .update(let results, _, _, _):
                self.groupItems = Array(results)
                self.tableView.reloadData()
                
            case .error(let error):
                print("Error: ", error)
            }
        }
        
        GroupAPI(Session.instance).get{ [weak self] groups in
            guard let self = self else { return }
                self.groupDB.addUpdate(groups!.response.items)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if groupItems[indexPath.row].groupDescription == "" {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCellNoDesc") as? GroupTableViewCellNoDesc
            else { return UITableViewCell() }
            
            cell.configure(groupItems[indexPath.row])
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupTableViewCell
            else { return UITableViewCell() }
            
            cell.configure(groupItems[indexPath.row])
            return cell
            
        }
    }
}
