//
//  PhotoListViewModel.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class PhotoListViewModel: PhotoListViewModelActions {
    let imageLoaderService = StringImageLoader()

    // MARK: - Variables
    private var currentPage  = BehaviorRelay(value: 1)
    private let photoService = PhotoService.shared
    private let disposeBag   = DisposeBag()
    
    var photoList       = BehaviorRelay<[PhotoListModel]>(value: [])
    var imageDownloaded = PublishRelay<(Int, UIImage?)>()
    
    init() {
        self.fetchImages(currentPage: self.currentPage.value)
    }
}

extension PhotoListViewModel {
    /// Loading images from given api
    func fetchImages(currentPage: Int) {
        self.photoService.getPhotos(currentPage: "\(currentPage)") { [weak self] response in
            switch response {
            case .failure(let e):
                print("error", e.localizedDescription)
                self?.photoList.accept([])
                
            case .success(let data):
                self?.photoList.accept(data)
            }
        }
    }
    
    /// loading image from given string
    func loadImageFromGivenItem(with index: Int) {
        let givenElementString = photoList.value[index].urls?.regular ?? ""

        imageLoaderService.loadRemoteImageFrom(urlString: givenElementString) { [weak self] image in
            print("image downloaded: \(index): ", image?.description)
            self?.imageDownloaded.accept((index, image))
        }
    }
}
