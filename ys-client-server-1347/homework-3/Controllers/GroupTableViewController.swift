//
//  GroupTableViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupTableViewCell else { return UITableViewCell() }
        
        let tempGroup = Group(id: 0,
                              Name: "Факинг Щит!",
                              imageURL: "https://fuckingshit.com/image.jpg",
                              description: "Это группа факинга щита!",
                              membersCount: 2398)
        
        cell.configure(tempGroup)

        return cell
    }
}
