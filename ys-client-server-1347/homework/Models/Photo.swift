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
    let height: Int?
    let photo1280, photo130, photo2560, photo604: String?
    let photo75, photo807: String?
    let postID: Int?
    let text: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case height
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo2560 = "photo_2560"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"
        case postID = "post_id"
        case text, width
    }
}

