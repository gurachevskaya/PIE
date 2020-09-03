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
    }

    //MARK: - RecipeLoading
    
    override func startLoading() {
          recipesPresenter.loadFavouriteRecipes()
      }
    
      //MARK: - Actions
    
    @objc func deleteButtonPressed() {
        
        showDeleteAlert()
    }
    
    func showDeleteAlert() {
        if recipesPresenter.isEmpty == false {
            let alertVC = UIAlertController(title: nil, message: "Are you sure to delete all favourite recipes?", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default,
                                            handler: {(_) in
                                                self.recipesPresenter.removeAllRecipes()
            }))
            alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}


