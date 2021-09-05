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
    @IBOutlet weak var friendMenuButton: UIButton!
    @IBOutlet weak var friendOnlineStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendMenuButton.menu = friendsMenu
        friendMenuButton.showsMenuAsPrimaryAction = true
    }

    override func prepareForReuse() {
        friendImage.image = nil
    }
    
    func configure(_ friendItem: FriendItem) {
        
        friendName.text = "\(friendItem.firstName) \(friendItem.lastName)"
        friendImage.image = UIImage(named: "placeholder")
        
        var friendFemale: Bool {
            switch friendItem.sex {
            case 2:
                return false
            case 1:
                return true
            default:
                return false
            }
        }
        
        if friendItem.online == 1 {
            friendOnlineStatus.text = "Онлайн"
            friendOnlineStatus.textColor = UIColor.systemGreen
        } else {
            friendOnlineStatus.text = friendFemale ? "Была " : "Был "
            friendOnlineStatus.text! += friendItem.lastSeen?.time.getRelativeDateStringFromUTC().lowercased() ?? ""
            friendOnlineStatus.textColor = UIColor.secondaryLabel
        }
        
        if let friendPhoto = friendItem.photo100 {
            friendImage.asyncLoadImageUsingCache(withUrl: friendPhoto)
        }
    }
}
