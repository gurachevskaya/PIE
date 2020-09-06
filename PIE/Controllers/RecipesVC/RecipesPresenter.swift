//
//  RecipesPresenter.swift
//  PIE
//
//  Created by Karina on 8/31/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import CoreData

protocol RecipeView: class {
    func reloadData()
}

let imageCache = NSCache<NSString, UIImage>()

final class RecipesPresenter: NSObject, NSFetchedResultsControllerDelegate {
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<RecipeEntity> = {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
            fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    
    var recipes: [Recipe] = []
    weak var view: RecipeView?
    var networkManager: NetworkManager
    var coreDataManager: CoreDataManager
    
    var searchQuery = ""
    
    init(networkManager: NetworkManager = NetworkManager(), coreDataManager: CoreDataManager = CoreDataManager()) {
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
    }
    
    var numberOfRecipes: Int {
        return recipes.count
    }
      
    //MARK: - Core Data
    
    var isEmpty: Bool {
        return coreDataManager.fetchRecipes().count == 0 ? true : false
    }
    
    func loadFavouriteRecipes() {
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            print(error)
        }
        
        for recipeEntity in fetchedResultsController.fetchedObjects! {
            let recipe = createRecipeWith(recipeEntity: recipeEntity)
            recipes.append(recipe)
        }
        view?.reloadData()
    }
    
    
    func removeAllRecipes() {
        coreDataManager.deleteAllRecipes()
        do {
        try fetchedResultsController.performFetch()
        } catch let error {
            print(error)
        }
        recipes.removeAll()
        view?.reloadData()
    }
    
     //MARK: - Networking
    
    func loadImageForUrl(urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            completion(.success(image))
        } else {
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            networkManager.performDataTask(with: request) { (result) in
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
    
    //MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            recipes.remove(at: indexPath!.row)
            view?.reloadData()
        case .insert:
            let newRecipe = createRecipeWith(recipeEntity: anObject as! RecipeEntity)
            recipes.insert(newRecipe, at: newIndexPath!.row)
            view?.reloadData()
        default:
            return
        }
    }
    
     //MARK: - Helpers
    
    func createRecipeWith(recipeEntity: RecipeEntity) -> Recipe {
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
        return recipe
    }
}





