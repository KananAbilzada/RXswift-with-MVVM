//
//  Dimensions.swift
//  Photos
//
//  Created by Kanan Abilzada on 01.12.21.
//

import UIKit

struct Dimensions {
    static let screenWidth: CGFloat
        = UIScreen.main.bounds.width
    static let screenHeight: CGFloat
        = UIScreen.main.bounds.height
    
    static let photosItemSize
        = CGSize(width: Dimensions.screenWidth / 3 - 20,
                 height: Dimensions.screenWidth * 0.35)
}
