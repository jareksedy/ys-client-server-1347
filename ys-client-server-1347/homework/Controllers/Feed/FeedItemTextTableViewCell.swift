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

        feedItemText.text = text
        
//        if text.numberOfWords > maxWordsCount {
//        } else {
//        }
    }
}
