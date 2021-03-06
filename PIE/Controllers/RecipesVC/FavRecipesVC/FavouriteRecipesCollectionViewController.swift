//
//  FavouriteRecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/26/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class FavouriteRecipesCollectionViewController: RecipesCollectionViewController {
    
    //MARK: - App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavourites()
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(deleteButtonPressed))
        navigationItem.rightBarButtonItems?.append(deleteButton)
    }
    
    //MARK: - RecipeLoading
    
    func loadFavourites() {
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
                                            handler: { [weak self] (_) in
                                                guard let self = self else { return }
                                                self.recipesPresenter.removeAllRecipes()
            }))
            alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}


