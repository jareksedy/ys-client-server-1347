//
//  PhotoCollectionViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import ImageViewer_swift
import SDWebImage

class PhotoCollectionViewController: UICollectionViewController {
    
    var photoItems: [PhotoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoAPI(Session.instance).get{ [weak self] photos in
            guard let self = self else { return }
            self.photoItems = photos!.response.items!
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoView.image = UIImage(named: "placeholder")

        AF.request(photoItems[indexPath.row].photo604!, method: .get).responseImage { response in

            guard let image = response.value else { return }
            cell.photoView.image = image

            cell.photoView.setupImageViewer(options: [.closeIcon(UIImage(systemName: "arrow.backward")!),
                                                      .theme(self.traitCollection.userInterfaceStyle == .light ? .light : .dark)])
            cell.photoIndicator.stopAnimating()
        }
        
        return cell
    }
}
