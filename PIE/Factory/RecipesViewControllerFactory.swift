//
//  RecipesFactory.swift
//  PIE
//
//  Created by Karina on 8/25/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

enum ControllerType {
    case allRecipes, favouriteRecipes
}

class RecipesViewControllerFactory {
    
    func makeRecipeViewController(type: ControllerType) -> RecipesCollectionViewController {
        switch type {
        case .allRecipes:
            return AllRecipesBuilder().build() as! RecipesCollectionViewController
        case .favouriteRecipes:
            return FavouriteRecipesBuilder().build() as! RecipesCollectionViewController
        }
    }
}
