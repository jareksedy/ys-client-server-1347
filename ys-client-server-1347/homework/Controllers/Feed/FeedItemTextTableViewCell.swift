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
            label.urlMaximumLength = 25
            label.enabledTypes = [.url, .hashtag]
            
            label.URLColor = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 1)
            label.URLSelectedColor = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 0.5)
            
            label.hashtagColor = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 1)
            label.hashtagSelectedColor = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 0.5)
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
        }
        
//        if text.numberOfWords > maxWordsCount {
//        } else {
//        }
    }
}
