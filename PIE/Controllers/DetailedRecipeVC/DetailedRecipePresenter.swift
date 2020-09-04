//
//  DetailedRecipePresenter.swift
//  PIE
//
//  Created by Karina on 8/28/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation
import UIKit

final class DetailedRecipePresenter {
    
    var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var label: String {
        return recipe.label
    }
    
    var calories: String {
        return "\(Int(recipe.calories / recipe.yield))"
    }
    
    var servings: String {
        return recipe.yield.removeZerosFromEnd()
    }
    
    var source: String {
        return "on " + recipe.source
    }
    
    var ingredients: String {
        var ingredientsText = ""
        for row in recipe.ingredientLines {
            ingredientsText += "🥣 " + row + "\n"
        }
        return ingredientsText
    }
    
    var isInFavourites: Bool {
        return RecipeEntity.isInFavourites(recipe: recipe)
    }
    
    func addInFavourites() {
        RecipeEntity.addRecipe(recipe: recipe)
    }
    
    func deleteFromFavourites() {
        RecipeEntity.deleteRecipe(recipe: recipe)
    }
    
    func openUrl() {
        guard let url = URL(string: recipe.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    var saveMessage: String {
        if RecipeEntity.isInFavourites(recipe: self.recipe) {
            return "Already saved"
        } else {
            return "Successfully saved"
        }
    }
}

