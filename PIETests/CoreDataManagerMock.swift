//
//  CoreDataManagerMock.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import CoreData
@testable import PIE

class CoreDataManagerMock: CoreDataManager {
    
    fileprivate var recipes: [RecipeEntity]
    var deleteAllRecipesCalled = false
//    var isInFavouritesCalled = false
    var addRecipeCalled = false
    var deleteRecipeCalled = false
    
    init(recipes: [RecipeEntity]) {
        self.recipes = recipes
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate unavailable")
        }
        super.init(container: appDelegate.persistentContainer)
    }
    
    override func fetchRecipes() -> [RecipeEntity] {
        return recipes
    }
    
    override func deleteAllRecipes() {
        deleteAllRecipesCalled = true
    }
    
    override func isInFavourites(recipe: Recipe) -> Bool {
//        isInFavouritesCalled = true
        return true
    }
    
    override func addRecipe(recipe: Recipe) {
        addRecipeCalled = true
    }
    
    override func deleteRecipe(recipe: Recipe) {
        deleteRecipeCalled = true
    }
    
    
    
    
    
    
}
