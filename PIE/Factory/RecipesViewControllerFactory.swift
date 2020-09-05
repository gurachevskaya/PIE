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
//        let searchPresenter = SearchPresenter(model: filtersModel)
        return (AllRecipesCollectionViewController(recipesPresenter: presenter))
    }
    
    func makeFavouriteRecipesViewController() -> RecipesCollectionViewController {
        let presenter = RecipesPresenter()
//        let searchPresenter = SearchPresenter(model: filtersModel)
        return (FavouriteRecipesCollectionViewController(recipesPresenter: presenter))
    }
}
