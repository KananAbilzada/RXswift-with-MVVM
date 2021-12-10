//
//  PhotoListViewModelActions.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import Foundation
import RxSwift

protocol PhotoListViewModelActions: AnyObject {
    func fetchImages(
        currentPage: Int
    )
}
