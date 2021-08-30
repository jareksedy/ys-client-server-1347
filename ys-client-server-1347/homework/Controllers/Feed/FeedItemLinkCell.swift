//
//  FeedItemLinkCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 30.08.2021.
//

import Foundation
import UIKit

class FeedItemLinkCell: UITableViewCell {
    
    @IBOutlet weak var linkTitle: UILabel!
    @IBOutlet weak var linkURL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(link: Link) {
     
        linkTitle.text = link.title ?? "No title"
        linkURL.text = link.url
        
    }
}
