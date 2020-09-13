//
//  FavouriteRecipesBuilder.swift
//  PIE
//
//  Created by Karina on 9/13/20.
//  Copyright © 2020 Karina. All rights reserved.
//
import UIKit

class FavouriteRecipesBuilder: ModuleBuilder {
    func build() -> UIViewController {
        let presenter = RecipesPresenter()
        let controller = (FavouriteRecipesCollectionViewController(recipesPresenter: presenter))
        presenter.view = controller
        return controller
    }
}

