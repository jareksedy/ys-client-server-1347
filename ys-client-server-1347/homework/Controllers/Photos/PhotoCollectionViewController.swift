//
//  PhotoCollectionViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {
    
    var photoItems: [PhotoItem] = []
    let photoDB = PhotoDB()
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localPhotosResults = photoDB.get()
        
        token = localPhotosResults.observe { (changes: RealmCollectionChange) in
            
            switch changes {
            
            case .initial(let results):
                self.photoItems = Array(results)
                self.collectionView.reloadData()
                
            case .update(let results, _, _, _):
                self.photoItems = Array(results)
                self.collectionView.reloadData()
                
            case .error(let error):
                print("Error: ", error)
            }
        }
        
        PhotoAPI(Session.instance).get{ [weak self] photos in
            guard let self = self else { return }
                self.photoDB.addUpdate(photos!)
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
