//
//  RecipeEntity+CoreDataClass.swift
//  
//
//  Created by Karina on 8/26/20.
//
//

import Foundation
import CoreData


public class RecipeEntity: NSManagedObject {
    
    static let manager = CoreDataManager.sharedManager
    
    static func fetchRecipes() -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        guard let favoritesRecipes = try? manager.viewContext.fetch(request) else { return [] }
        return favoritesRecipes
    }
    
    static func deleteAllRecipes() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try manager.viewContext.execute(deleteRequest)
            try manager.viewContext.save()
        } catch {
            print ("\(error.localizedDescription)")
        }
    }
    
    static func addRecipe(recipe: Recipe) {
        
        guard !isInFavourites(recipe: recipe) else {return}
        
        let favRecipe = RecipeEntity(context: manager.viewContext)
        
        favRecipe.date = Date()
        favRecipe.calories = recipe.calories
        favRecipe.dietLabels = recipe.dietLabels
        favRecipe.healthLabels = recipe.healthLabels
        favRecipe.image = recipe.image
        favRecipe.ingredientLines = recipe.ingredientLines
        favRecipe.label = recipe.label
        favRecipe.sourse = recipe.source
        favRecipe.totalTime = recipe.totalTime
        favRecipe.totalWeight = recipe.totalWeight
        favRecipe.uri = recipe.uri
        favRecipe.url = recipe.url
        favRecipe.yield = recipe.yield
        
        do {
            try manager.viewContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    static func isInFavourites(recipe: Recipe) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "uri = %@", recipe.uri)
        guard let alreadyExists = try? manager.viewContext.fetch(request) else { return false }
        if alreadyExists.isEmpty {
            return false
        } else {
        return true
        }
    }
    
    static func deleteRecipe(recipe: Recipe) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "uri = %@", recipe.uri)
        guard let fetchResult = try? manager.viewContext.fetch(request) else { return }
        guard let recipeToDelete = fetchResult.first else { return }
        manager.viewContext.delete(recipeToDelete)
        
        do {
            try manager.viewContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
}
