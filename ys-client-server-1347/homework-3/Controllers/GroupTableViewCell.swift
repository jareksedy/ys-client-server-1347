//
//  GroupTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupImage: RoundedImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupMemebersCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ group: Group) {
        groupName.text = group.Name
        groupDescription.text = group.description
        groupMemebersCount.text = "\(group.membersCount) подписчиков"
    }

}
