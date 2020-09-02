//
//  RecipesPresenter.swift
//  PIE
//
//  Created by Karina on 8/31/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

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
        view?.reloadData()
    }
    
    func loadImageForUrl(urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
           if let image = imageCache.object(forKey: urlString as NSString) {
               completion(.success(image))
           } else {
               let url = URL(string: urlString)!
               let request = URLRequest(url: url)
               
               NetworkManager.sharedManager.performDataTask(with: request) { (result) in
                   switch result {
                   case .failure(let appError):
                       completion(.failure(appError))
                       
                   case .success(let data):
                       let image = UIImage(data: data)
                       imageCache.setObject(image!, forKey: urlString as NSString)
                       completion(.success(image!))
                   }
               }
           }
       }
    
}


