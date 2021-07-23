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
    
    let userDB = UserDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localUser = UserDB().get()
        
        if localUser != nil {
            display(localUser!)
        }
        
        UserAPI(Session.instance).get{ user in
            guard let user = user else { return }
            if user != localUser {
                self.update(user)
            }
        }
    }
    
    private func display(_ user: User) {
        
        self.userName.text = "\(user.firstName) \(user.lastName)"
        self.userLocation.text = "\(user.city), \(user.country)."
        
        if let imageURL = user.imageURL {
            AF.request(imageURL, method: .get).responseImage { response in
                guard let image = response.value else { return }
                self.userImage.image = image
            }
        }
    }
    
    private func update(_ user: User) {
        
        userDB.addUpdate(user)
        self.display(user)
    }
}
