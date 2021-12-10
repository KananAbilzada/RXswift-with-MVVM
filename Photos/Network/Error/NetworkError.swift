//
//  NetworkError.swift
//  Photos
//
//  Created by Kanan Abilzada on 30.11.21.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case unknown
    case canNotGetData
}
