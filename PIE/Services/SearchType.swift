//
//  SearchType.swift
//  PIE
//
//  Created by Karina on 9/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

enum SearchType {
    case simpleSearch
    case ingredientsSearch
    
    var text: String {
        switch self {
        case .simpleSearch:
            return "Simple search by name"
        case .ingredientsSearch:
            return "Find recipes based on what you already have at home!"
        }
    }
    
    var image: UIImage {
        switch self {
        case .simpleSearch:
            return UIImage(named: "dish")!
        case .ingredientsSearch:
            return UIImage(named: "list")!
        }
    }
}
