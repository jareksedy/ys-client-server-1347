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
        
        UserAPI(Session.instance).get{ [weak self] user in
            guard let self = self else { return }
            self.display(user!)
        }
    }
    
    private func display(_ user: User) {
        
        self.userName.text = "\(user.response[0].firstName) \(user.response[0].lastName)"
        self.userLocation.text = "\(user.response[0].city.title), \(user.response[0].country.title)."
        
        if let imageURL = user.response[0].photo200 {
            AF.request(imageURL, method: .get).responseImage { response in
                guard let image = response.value else { return }
                self.userImage.image = image
            }
        }
    }
}
