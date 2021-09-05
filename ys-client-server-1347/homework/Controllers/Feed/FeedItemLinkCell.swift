//
//  FeedItemLinkCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 30.08.2021.
//

import Foundation
import UIKit
import ActiveLabel
import Alamofire

class FeedItemLinkCell: UITableViewCell {
    
    @IBOutlet weak var linkTitle: UILabel!
    @IBOutlet weak var linkPhoto: UIImageView!
    @IBOutlet weak var linkURL: ActiveLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        linkPhoto.image = nil
    }
    
    func configure(link: Link) {
     
        linkTitle.text = link.title ?? "Без названия..."
        
        linkURL.customize { label in
            
            label.text = link.url
            
            label.enabledTypes = [.url]
            
            label.URLColor = activeURLColor
            label.URLSelectedColor = activeURLColorSelected
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
        }
        
        guard let linkPhotoUrl = link.photo?.photo604 else { return }
        linkPhoto.asyncLoadImageUsingCache(withUrl: linkPhotoUrl)
    }
}
