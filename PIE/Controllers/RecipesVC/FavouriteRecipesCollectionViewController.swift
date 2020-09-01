//
//  FavouriteRecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/26/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

class FavouriteRecipesCollectionViewController: RecipesCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startLoading()
    }
    
    func startLoading() {
          recipesPresenter.loadFavouriteRecipes()
          collectionView.reloadData()
      }
}

