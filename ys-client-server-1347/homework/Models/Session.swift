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
    
    // My Client ID's
    // 7937012
    // 7938282
    
    let cliendId = "7938282"
    let version = "5.68"
}
