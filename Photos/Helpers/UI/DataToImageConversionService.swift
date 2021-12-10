//
//  DataToImageConversionService.swift
//  Photos
//
//  Created by Kanan Abilzada on 30.11.21.
//

import UIKit

protocol StringImageLoaderActions: AnyObject {
    func loadRemoteImageFrom(urlString: String,
                             completion: @escaping (UIImage?) -> Void)
}

class StringImageLoader: StringImageLoaderActions {
    func loadRemoteImageFrom(urlString: String,
                             completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let resultImageData = data {
                if let img = UIImage(data: resultImageData) {
                    completion(img)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
