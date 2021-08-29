//
//  FriendsTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 27.08.2021.
//

import UIKit
import Alamofire

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendImage: RoundedImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendOnlineStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ friendItem: FriendItem) {
        
        friendName.text = "\(friendItem.firstName) \(friendItem.lastName)"
        friendImage.image = UIImage(named: "placeholder")
        
        if friendItem.online == 1 {
            friendOnlineStatus.text = "Онлайн"
            friendOnlineStatus.textColor = UIColor.systemGreen
        } else {
            friendOnlineStatus.text = friendItem.lastSeen?.time.getDateStringFromUTC() ?? ""
            friendOnlineStatus.textColor = UIColor.secondaryLabel
        }
        
        if let friendPhoto = friendItem.photo100 {
            AF.request(friendPhoto, method: .get).responseImage { response in
                guard let image = response.value else { return }
                self.friendImage.image = image
            }
        }
        
        
    }

}
