//
//  PhotoCollectionViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewController: UICollectionViewController {
    
    var photoItems: [PhotoItem] = []
    let photoDB = PhotoDB()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localPhotos = photoDB.get()
        
        if localPhotos.count > 0 {
            photoItems = localPhotos
        }
        
        PhotoAPI(Session.instance).get{ [weak self] photos in
            guard let self = self else { return }
            if photos != localPhotos {
                self.photoItems = photos!
                self.photoDB.addUpdate(photos!)
            }
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell

        AF.request(photoItems[indexPath.row].photo604!, method: .get).responseImage { response in
            guard let image = response.value else { return }
            cell.photoView.image = image
        }
        
        return cell
    }
}
