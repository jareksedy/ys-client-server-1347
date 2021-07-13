//
//  UserInfoViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userImage: RoundedImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var pinIcon: UIImageView!
    @IBOutlet weak var userLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserAPI(Session.instance).get{ user in
            
            guard let user = user else { return }
            self.userName.text = "\(user.firstName) \(user.lastName)"
            self.userLocation.text = "\(user.city), \(user.country)."
            
            if let imageURL = user.imageURL {
                AF.request(imageURL, method: .get).responseImage { response in
                    guard let image = response.value else { return }
                    self.userImage.image = image
                }
            }
        }
    }
}
