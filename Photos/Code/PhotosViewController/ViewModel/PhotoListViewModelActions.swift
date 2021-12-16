//
//  PhotoListViewModelActions.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import Foundation
import RxCocoa

protocol PhotoListViewModelActions: AnyObject {
    func fetchImages(
        currentPage: Int
    )
    
    var photoList       : BehaviorRelay<[PhotoListModel]> { get }
    var imageDownloaded : PublishRelay<(Int, UIImage?)> { get }
    var scrollEnded     : PublishRelay<Void> { get }
}
