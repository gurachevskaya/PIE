//
//  RecipesPresenter.swift
//  PIE
//
//  Created by Karina on 8/31/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

final class RecipesPresenter {

     var recipes: [Recipe] = []
    weak var view: RecipeView?
    
    var numberOfRecipes: Int {
        return recipes.count
    }
    
    func loadFavouriteRecipes() {
        let fetchResult = RecipeEntity.fetchRecipes()
        for recipeEntity in fetchResult {
            let recipe = Recipe(uri: recipeEntity.uri!,
                                label: recipeEntity.label!,
                                image: recipeEntity.image!,
                                source: recipeEntity.sourse!,
                                url: recipeEntity.url!,
                                yield: recipeEntity.yield,
                                dietLabels: recipeEntity.dietLabels!,
                                healthLabels: recipeEntity.healthLabels!,
                                ingredientLines: recipeEntity.ingredientLines!,
                                calories: recipeEntity.calories,
                                totalWeight: recipeEntity.totalWeight,
                                totalTime: recipeEntity.totalTime)
            
            recipes.append(recipe)
        }
    }
        
        
}
