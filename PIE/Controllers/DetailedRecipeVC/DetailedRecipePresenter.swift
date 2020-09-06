//
//  DetailedRecipePresenter.swift
//  PIE
//
//  Created by Karina on 8/28/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

final class DetailedRecipePresenter {
    
    var recipe: Recipe
    let coreDataManager: CoreDataManager
    
    init(recipe: Recipe, coreDataManager: CoreDataManager = CoreDataManager()) {
        self.recipe = recipe
        self.coreDataManager = coreDataManager
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
    
    var dietsAndHealth: String {
        var text = ""
        for diet in recipe.dietLabels {
            text += "◦" + diet + " "
        }
        for health in recipe.healthLabels {
            text += "◦" + health + " "
        }
        return text
    }
    
    var isInFavourites: Bool {
        return coreDataManager.isInFavourites(recipe: recipe)
    }
    
    func addInFavourites() {
        coreDataManager.addRecipe(recipe: recipe)
    }
    
    func deleteFromFavourites() {
        coreDataManager.deleteRecipe(recipe: recipe)
    }
    
    func openUrl() {
        guard let url = URL(string: recipe.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
//    var saveMessage: String {
//        if coreDataManager.isInFavourites(recipe: self.recipe) {
//            return "Already saved"
//        } else {
//            return "Successfully saved"
//        }
//    }
}

