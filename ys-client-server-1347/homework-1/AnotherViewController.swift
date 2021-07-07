//
//  AnotherViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.07.2021.
//

import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = Session.instance
        userIdLabel.text = "User ID: \(session.userId)"
        tokenLabel.text = "Session token: \(session.token)"
    }
}
