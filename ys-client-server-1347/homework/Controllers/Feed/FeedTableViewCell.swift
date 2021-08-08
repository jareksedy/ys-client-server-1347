//
//  FeedTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.08.2021.
//

import UIKit
import Alamofire

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var postUserGroupImage: RoundedImageView!
    @IBOutlet weak var postUserGroupName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(item: Item, profile: Profile? = nil, group: Group? = nil) {
        
        if let group = group {
            postUserGroupName.text = group.name
            
            AF.request(group.photo100, method: .get).responseImage { response in
                guard let image = response.value else { return }
                self.postUserGroupImage.image = image
            }

        } else {
            if let profile = profile {
                
                postUserGroupName.text = "\(profile.firstName) \(profile.lastName)"
                
                AF.request(profile.photo100, method: .get).responseImage { response in
                    guard let image = response.value else { return }
                    self.postUserGroupImage.image = image
                }
            }
        }
        
        postDate.text = item.date.getDateStringFromUTC()
        postText.text = item.text
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date)
    }
}
