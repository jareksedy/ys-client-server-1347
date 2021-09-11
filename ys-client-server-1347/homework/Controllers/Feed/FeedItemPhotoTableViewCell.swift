//
//  FeedItemPhotoTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 16.08.2021.
//

import UIKit

class FeedItemPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedItemPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        feedItemPhoto.image = nil
    }
    
    func configure(url: String? = nil) {
        
        guard let url = url else { return }
        feedItemPhoto.asyncLoadImageUsingCache(withUrl: url, withImageViewer: false)
    }
}
