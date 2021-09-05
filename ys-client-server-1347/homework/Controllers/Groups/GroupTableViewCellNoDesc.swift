//
//  GroupTableViewCellNoDesc.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import Alamofire

class GroupTableViewCellNoDesc: UITableViewCell {
    
    @IBOutlet weak var groupImage: RoundedImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        groupImage.image = nil
    }
    
    func configure(_ groupItem: GroupItem) {
        
        groupName.text = groupItem.name
        groupImage.image = UIImage(named: "placeholder")
        
        membersCount.text =  "\(groupItem.membersCount.formatted) подписчиков"
        
        groupImage.asyncLoadImageUsingCache(withUrl: groupItem.imageURL)
    }
}
