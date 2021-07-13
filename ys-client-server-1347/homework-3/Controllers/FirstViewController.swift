//
//  FirstViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 09.07.2021.
//

import UIKit
import WebKit

class FirstViewController: UIViewController {
    
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
            URLQueryItem(name: "client_id", value: "7902471"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            //URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        //print(request.description)
        
        wk.load(request)
    }
}

extension FirstViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"],
              let userId = params["user_id"] else {
            print("Что-то пошло не так!")
            return
        }
        
        let session = Session.instance
        
        session.userId = Int(userId)!
        session.token = token
        
        performSegue(withIdentifier: "goWest", sender: self)
        
        decisionHandler(.cancel)
    }
}
