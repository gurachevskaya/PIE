//
//  AllRecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 9/4/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

class AllRecipesCollectionViewController: RecipesCollectionViewController {
    
    // MARK: - UIScrollViewDelegate
      
      override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
              if searchPresenter.more {
                searchPresenter.getRecipes(searchQuery: recipesPresenter.searchQuery) { [weak self] (result) in
                      switch result {
                      case .failure(let appError):
                          if case .noRecipes = (appError as AppError) {
                              self?.showAlertWithMessage(message: "You have seen all recipes with this search parameters\n p.s.this API plan allows only 100 recipes in one search")
                          } else if case .tooManyRequests = (appError as AppError) {
                               self?.showAlertWithMessage(message: "Your API plan allows 5 requests/min. Wait a little")
                          } else {
                              self?.showAlertWithMessage(message: "\(appError)")
                          }

                      case .success(let recipes):
                          DispatchQueue.main.async {
                              self?.recipesPresenter.recipes.append(contentsOf: recipes)
                              self?.reloadData()
                          }
                      }
                  }
              } else {
                  showAlertWithMessage(message: "That's all recipes with this search parameters")
              }
          }
      }

}
