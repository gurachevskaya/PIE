//
//  Errors.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkError(Error) 
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case noSearchParameters
    case noRecipes
    case tooManyRequests
}


extension AppError: Equatable {
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL):
            return true
        case (.noResponse, .noResponse):
            return true
        case (.networkError, .networkError):
            return true
        case (.noData, .noData):
            return true
        case (.decodingError, .decodingError):
            return true
        case (.badStatusCode, .badStatusCode):
            return true
        case (.noSearchParameters, .noSearchParameters):
            return true
        case (.noRecipes, .noRecipes):
            return true
         case (.tooManyRequests, .tooManyRequests):
            return true

        case (.badURL, _), (.noResponse, _), (.networkError, _), (.noData, _), (.decodingError, _), (.badStatusCode, _), (.noSearchParameters, _), (.noRecipes, _), (.tooManyRequests, _):
            return false
        }
    }
}
