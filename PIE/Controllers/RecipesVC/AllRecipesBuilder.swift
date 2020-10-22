//
//  AllRecipesBuilder.swift
//  PIE
//
//  Created by Karina on 9/13/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class AllRecipesBuilder: ModuleBuilder {
    
    func build() -> UIViewController {
        let presenter = RecipesPresenter()
        let controller = (AllRecipesCollectionViewController(recipesPresenter: presenter))
        presenter.view = controller
        return controller
    }
}
