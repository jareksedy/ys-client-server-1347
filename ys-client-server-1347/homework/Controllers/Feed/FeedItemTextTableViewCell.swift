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
        
        let firstLine = String(text.firstLine!)

        feedItemText.customize { label in
            
            if text.numberOfWords > maxWordsCount {
                label.text = firstLine
                label.text! += "\n"
                label.text! += readMore
            } else {
                label.text = text
            }

            let readMoreType = ActiveType.custom(pattern: "\\s\(readMore)\\b")
            
            label.urlMaximumLength = 25
            label.enabledTypes = [.url, .hashtag, readMoreType]
            
            label.customColor[readMoreType] = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 1)
            label.customSelectedColor[readMoreType] = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 0.5)
            
            label.URLColor = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 1)
            label.URLSelectedColor = UIColor(red: 41.0/255, green: 151.0/255, blue: 255.0/255, alpha: 0.5)
            
            label.hashtagColor = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 1)
            label.hashtagSelectedColor = UIColor(red: 255.0/255, green: 123.0/255, blue: 114.0/255, alpha: 0.5)
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
            
            label.handleCustomTap(for: readMoreType) { _ in
                label.text = text
                label.layoutIfNeeded()
            }
        }
    }
}
