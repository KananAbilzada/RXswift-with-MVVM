//
//  PhotoService.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import Foundation

class PhotoService: PhotoServiceActions, Request {

    private let dataLoader: DataLoader
    
    // MARK: Request parameters
    var host: String
    var path: String
    var queryItems: [URLQueryItem]
    var headers: [String : String]
    
    static let shared = PhotoService()
    
    // MARK: - Initialization
    init() {
        dataLoader = DataLoader()
        
        self.host = ApiURL.baseURL
        self.path = ""
        self.queryItems = []
        self.headers = [:]
        
        setupHeaders()
    }
    
    // MARK: Request header setup
    private func setupHeaders () {
        self.headers = ["Authorization": "Client-ID \(ApiURL.apiKey)"]
    }
}


extension PhotoService {
    /// gets images from api
    /// - Parameter completion: completion handler for function
    /// - Parameter currentPage: represent current page's count
    func getPhotos(currentPage: String,
                   completion: @escaping (PhotoGetPhotosResponseType) -> Void) {
        self.path = "/photos"

        self.queryItems = []
        let perPage     = URLQueryItem(name: "per_page", value: "30")
        let currentPage = URLQueryItem(name: "page", value: currentPage)
        self.queryItems = [perPage, currentPage]
        
        dataLoader.request(self, decodable: [PhotoListModel].self) { response in
            completion(response)
        }
    }
}
