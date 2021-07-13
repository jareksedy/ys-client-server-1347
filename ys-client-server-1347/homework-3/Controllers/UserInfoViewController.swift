//
//  UserInfoViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userImage: RoundedImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var pinIcon: UIImageView!
    @IBOutlet weak var userLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserAPI(Session.instance).get{ user in
            print(user?.firstName ?? "none")
        }
        
        userImage.backgroundColor = UIColor.systemPink
    }
}
