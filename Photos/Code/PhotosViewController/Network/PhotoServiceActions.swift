//
//  PhotoServiceActions.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import Foundation

protocol PhotoServiceActions: AnyObject {
    func getPhotos(currentPage: String,
                   completion: @escaping (PhotoGetPhotosResponseType) -> Void)
}
