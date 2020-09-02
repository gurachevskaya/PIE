//
//  FavouriteRecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/26/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit
import CoreData

class FavouriteRecipesCollectionViewController: RecipesCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(deleteButtonPressed))
        navigationItem.rightBarButtonItems?.append(deleteButton)
        startLoading()
    }
    
    func startLoading() {
          recipesPresenter.loadFavouriteRecipes()
      }
    
    @objc func deleteButtonPressed() {
//        RecipeEntity.deleteAllRecipes()
    }
}


extension FavouriteRecipesCollectionViewController: NSFetchedResultsControllerDelegate {
    
    
    
    
}
