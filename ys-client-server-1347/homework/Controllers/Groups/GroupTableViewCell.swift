//
//  GroupTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import Alamofire

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
    
    func configure(_ groupItem: GroupItem) {
        
        groupName.text = groupItem.name
        groupImage.image = UIImage(named: "placeholder")
        
        if let description = groupItem.groupDescription {
            groupDescription.text = description
        }
        
        groupMemebersCount.text =  "\(groupItem.membersCount.formatted) подписчиков"
        
        AF.request(groupItem.imageURL, method: .get).responseImage { response in
            guard let image = response.value else { return }
            self.groupImage.image = image
        }
    }
}
