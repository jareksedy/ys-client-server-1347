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
       
        cell.photoView.asyncLoadImageUsingCache(withUrl: photoItems[indexPath.row].photoAvailable!.url,
                                                withImageViewer: true,
                                                indicator: cell.photoIndicator)
        
        return cell
    }
}
