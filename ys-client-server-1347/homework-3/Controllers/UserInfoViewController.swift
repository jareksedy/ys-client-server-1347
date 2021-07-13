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
    
    let userData: User? = UserAPI(Session.instance).get()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.backgroundColor = UIColor.systemPink
    }
}
