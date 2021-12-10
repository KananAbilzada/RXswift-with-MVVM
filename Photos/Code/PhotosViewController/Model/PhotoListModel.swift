//
//  PhotoListModel.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import Foundation

struct PhotoListModel: Codable, Identifiable {
    let id: String?
    let updated_at: String?
    let urls: PhotoListItemModel?
}

struct PhotoListItemModel: Codable {
    var id: String?
    let small: String?
    let raw: String?
    let regular: String?
}
