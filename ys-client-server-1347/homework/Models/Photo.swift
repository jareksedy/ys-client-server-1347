//
//  Photo.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//


import Foundation

// MARK: - Feed
struct Photos: Codable {
    let response: PhotoResponse
}

// MARK: - Response
struct PhotoResponse: Codable {
    let count: Int
    let items: [PhotoItem]?
}

// MARK: - Item
struct PhotoItem: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let sizes: [Size]?
    let text: String?
    let lat, long: Double?
    let postID: Int?
    
    var actualPhoto: Size? {
        
        guard let sizes = self.sizes else { return nil }
        
        if let photo = sizes.first(where: {$0.type == .x}) { return photo }
        if let photo = sizes.first(where: {$0.type == .z}) { return photo }
        if let photo = sizes.first(where: {$0.type == .y}) { return photo }
        if let photo = sizes.first(where: {$0.type == .m}) { return photo }
        if let photo = sizes.first(where: {$0.type == .s}) { return photo }
        
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text, lat, long
        case postID = "post_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: TypeEnum
    let width: Int
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
    case k = "k"
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case e = "e"
    case l = "l"
    case temp = "temp"
}
