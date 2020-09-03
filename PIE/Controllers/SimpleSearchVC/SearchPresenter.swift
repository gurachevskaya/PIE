//
//  SimpleSearchPresenter.swift
//  PIE
//
//  Created by Karina on 8/28/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

protocol SimpleSearchView: class {
    func reloadData()
    func startLoading()
    func finishLoading()
}


final class SearchPresenter {
    
    weak var view: SimpleSearchView?
    
    var dietsString = ""
    var healthString = ""
    
    var numberOfFilters: Int {
        return filtersModel.count
    }
    
    subscript(index: Int) -> Filter {
        let filter = filtersModel[index]
        return filter
    }
    
    
    func toggleSelectedFor(item: Int) {
        filtersModel[item].toggleSelected()
        view?.reloadData()
    }
    
    
    func getRecipes(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError>) -> ()) {
        
        fillDietsAndHealth()
        
        if searchQuery.isEmpty && dietsString.isEmpty && healthString.isEmpty {
            completion(.failure(.noSearchParameters))
            return
        }
        self.view?.startLoading()
        RecipeAPI.fetchRecipe(for: searchQuery, page: 0, dietLabels: dietsString, healthLabels: healthString) { result in
            self.view?.finishLoading()
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let recipes):
                completion(.success(recipes))
            }
        }
    }

    
    func getRecipes(for ingredients: [String], completion: @escaping (Result<[Recipe], AppError>) -> ()) {
        
        let searchQuery = ingredients.joined(separator: "+")
        
        fillDietsAndHealth()
        
        if searchQuery.isEmpty {
            completion(.failure(.noSearchParameters))
            return
        }
         self.view?.startLoading()
        RecipeAPI.fetchRecipe(for: searchQuery, page: 0, dietLabels: dietsString, healthLabels: healthString) { result in
            self.view?.finishLoading()
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let recipes):
                completion(.success(recipes))
            }
        }
    }
    
    private func fillDietsAndHealth() {
        for filter in filtersModel {
            if filter.isSelected {
                if filter.label == .diet {
                    dietsString += ("&diet=" + filter.name)
                } else {
                    healthString += ("&health=" + filter.name)
                }
            }
        }
    }
    
   
    
    
}
