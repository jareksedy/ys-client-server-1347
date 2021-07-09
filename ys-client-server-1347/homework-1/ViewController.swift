//
//  ViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 07.07.2021.
//

import UIKit

//class Session {
//    
//    static let instance = Session()
//
//    private init() {}
//
//    var userId: Int = 0
//    var token: String = ""
//
//}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = Session.instance
        session.userId = 29392
        session.token = "somesessiontoken"
    }
}

