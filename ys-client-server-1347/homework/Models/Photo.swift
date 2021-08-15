//
//  Photo.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation

class PhotoItem: Codable {
    
    var id: Int = 0
    var albumID: Int = 0
    var ownerID: Int = 0
    var width: Int = 0
    var height: Int = 0
    var photo75, photo130, photo604, photo807, photo1280: String?
    var text: String?
    
    convenience required init(id: Int, albumID: Int, ownerID: Int, width: Int, height: Int, photo75: String?, photo130: String?, photo604: String?, photo807: String?, photo1280: String?, text: String?) {
        
        self.init()
        self.id = id
        self.albumID = albumID
        self.ownerID = ownerID
        self.width = width
        self.height = height
        self.photo75 = photo75
        self.photo130 = photo130
        self.photo604 = photo604
        self.photo807 = photo807
        self.photo1280 = photo1280
        self.text = text
    }
}
