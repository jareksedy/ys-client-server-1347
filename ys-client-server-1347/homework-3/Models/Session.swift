//
//  Session.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 09.07.2021.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var userId: Int = 0
    var token: String = ""
    
    let cliendId = "7902471"
    let version = "5.68"
}
