//
//  FeedItemPhotoTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 16.08.2021.
//

import UIKit
import Alamofire
import ImageViewer_swift

class FeedItemPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedItemPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(url: String? = nil, systemImageName: String? = nil) {
        
        feedItemPhoto.image = UIImage(named: "placeholder")
        
        if let systemImageName = systemImageName {
            feedItemPhoto.image = UIImage(named: systemImageName)
        } else {
            AF.request(url!, method: .get).responseImage { response in
                
                guard let image = response.value else { return }
                
                self.feedItemPhoto.image = image
                
                self.feedItemPhoto.setupImageViewer(options: [.closeIcon(UIImage(systemName: "arrow.backward")!),
                                                             .theme(self.traitCollection.userInterfaceStyle == .light ? .light : .dark)])
            }
        }
    }
    
}
