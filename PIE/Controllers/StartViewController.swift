//
//  StartViewController.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecipeAPI.fetchRecipe(for: "Cookie") { (result) in
            switch result{
            case .failure(let appError):
                print("error \(appError.localizedDescription)")
              // TODO: alert controller
            case .success(let recipes): break
//              self?.recipes = recipes
            }
        }
    }


    @IBAction func favouritesButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(RecipesCollectionViewController(nibName: "RecipesCollectionViewController", bundle: nil), animated: true)
    }
    
    @IBAction func ingredientsSearchButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(IngredientsSearchViewController(nibName: "IngredientsSearchViewController", bundle: nil), animated: true)
    }
    
    @IBAction func simpleSearchButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(SimpleSearchViewController(nibName: "SimpleSearchViewController", bundle: nil), animated: true)
//        navigationController?.pushViewController(RecipesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()), animated: true)
    }
    
}
