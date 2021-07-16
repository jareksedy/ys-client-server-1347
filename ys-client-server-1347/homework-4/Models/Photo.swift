//
//  Photo.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Foundation

struct PhotoItem {
    let id, albumID, ownerID: Int
    let width, height: Int
    let photo75, photo130, photo604, photo807, photo1280: String?
    let text: String?
}
