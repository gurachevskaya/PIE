//
//  CoreDataManager.swift
//  PIE
//
//  Created by Karina on 8/25/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate unavailable")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    
    func fetchRecipes() -> [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.includesPropertyValues = false
        guard let favoritesRecipes = try? viewContext.fetch(request) else { return [] }
        return favoritesRecipes
    }
    
    func deleteAllRecipes() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print ("\(error)")
        }
    }
    
    func addRecipe(recipe: Recipe) {
        
        guard !isInFavourites(recipe: recipe) else {return}
        
        let favRecipe = RecipeEntity(context: viewContext)
        
        favRecipe.date = Date()
        favRecipe.calories = recipe.calories
        favRecipe.dietLabels = recipe.dietLabels
        favRecipe.healthLabels = recipe.healthLabels
        favRecipe.image = recipe.image
        favRecipe.ingredientLines = recipe.ingredientLines
        favRecipe.label = recipe.label
        favRecipe.source = recipe.source
        favRecipe.totalTime = recipe.totalTime
        favRecipe.totalWeight = recipe.totalWeight
        favRecipe.uri = recipe.uri
        favRecipe.url = recipe.url
        favRecipe.yield = recipe.yield
        
        do {
            try viewContext.save()
        } catch {
            print("\(error)")
        }
    }
    
    func isInFavourites(recipe: Recipe) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "uri = %@", recipe.uri)
        guard let alreadyExists = try? viewContext.fetch(request) else { return false }
        if alreadyExists.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func deleteRecipe(recipe: Recipe) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "uri = %@", recipe.uri)
        guard let fetchResult = try? viewContext.fetch(request) else { return }
        guard let recipeToDelete = fetchResult.first else { return }
        viewContext.delete(recipeToDelete)
        
        do {
            try viewContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    
}
