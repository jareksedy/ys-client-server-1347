//
//  FirstViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 09.07.2021.
//

import UIKit
import WebKit

class FirstViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var wk: WKWebView! {
        didSet{
            wk.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVKAccessToken()
    }
    
    func getVKAccessToken() {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7899606"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]

        let request = URLRequest(url: urlComponents.url!)
        
        wk.load(request)
    }
}
