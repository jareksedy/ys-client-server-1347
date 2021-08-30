//
//  FeedItemTextTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 15.08.2021.
//

import UIKit
import ActiveLabel

class FeedItemTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedItemText: ActiveLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(text: String?) {
        
        guard let text = text else { return }

        feedItemText.customize { label in
            
            label.text = text
            
            let vkHashTag = ActiveType.custom(pattern: #"#\S+"#)
            
            label.urlMaximumLength = 22
            label.enabledTypes = [.url, vkHashTag]
            
            label.customColor[vkHashTag] = activeHashTagColor
            label.customSelectedColor[vkHashTag] = activeHashTagColor
            
            label.URLColor = activeURLColor
            label.URLSelectedColor = activeURLColorSelected
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
            
            label.handleCustomTap(for: vkHashTag) { hashtag in
                print("vkhashtag tapped \(hashtag).")
            }
        }
    }
}
