//
//  RecipesFactory.swift
//  PIE
//
//  Created by Karina on 8/25/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

struct RecipesViewControllerFactory {
    
    func makeAllRecipesViewController() -> RecipesCollectionViewController {
        let presenter = RecipesPresenter()
        return (RecipesCollectionViewController(recipesPresenter: presenter))
    }
    
    func makeFavouriteRecipesViewController() -> RecipesCollectionViewController {
        let presenter = RecipesPresenter()
        return (FavouriteRecipesCollectionViewController(recipesPresenter: presenter))
    }
}
