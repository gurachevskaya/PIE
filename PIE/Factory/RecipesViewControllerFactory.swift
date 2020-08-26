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
        return (AllRecipesCollectionViewController(nibName: "RecipesCollectionViewController", bundle: nil))
    }
    
    func makeFavouriteRecipesViewController() -> RecipesCollectionViewController {
        return (FavouriteRecipesCollectionViewController(nibName: "RecipesCollectionViewController", bundle: nil))
    }
}
