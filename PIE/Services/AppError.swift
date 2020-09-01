//
//  Errors.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String) // associated value
    case noResponse
    case networkError(Error) // no internet connection
    case noData
    case decodingError(Error)
    case badStatusCode(Int) // 401, 404, 500
    case badMimeType(String) // image/jpg
    case noSearchParameters
    case noRecipes
}

