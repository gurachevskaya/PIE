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
        
       
    }


    @IBAction func favouritesButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(RecipesViewControllerFactory().makeFavouriteRecipesViewController(), animated: true)
    }
    
    @IBAction func ingredientsSearchButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(IngredientsSearchViewController(nibName: "IngredientsSearchViewController", bundle: nil), animated: true)
    }
    
    @IBAction func simpleSearchButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(SimpleSearchViewController(simpleSearchPresenter: SimpleSearchPresenter()), animated: true)
//        navigationController?.pushViewController(SimpleSearchViewController(nibName: "SimpleSearchViewController", bundle: nil), animated: true)

    }
    
//    @IBAction func allRecipesButtonPressed(_ sender: Any) {
//        navigationController?.pushViewController(RecipesViewControllerFactory().makeAllRecipesViewController(), animated: true)
//    }
    
    @IBAction func detailedButtonPressed(_ sender: Any) {
        navigationController?.pushViewController(DetailedRecipeViewController(nibName: "DetailedRecipeViewController", bundle: nil), animated: true)
    }
    
}
