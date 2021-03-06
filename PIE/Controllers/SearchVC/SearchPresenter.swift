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
    var model: [Filter]
    var recipeAPI: RecipeAPI
    
    var more: Bool!
    let recipesInOneRequest = 20
    var from = 0
    var to = 20
   
    
    init(model: [Filter], recipeAPI: RecipeAPI = RecipeAPI()) {
        self.recipeAPI = recipeAPI
        self.model = model
    }
        
    var dietsString: String {
        var string = ""
        for filter in model {
            if filter.isSelected {
                if filter.label == .diet {
                    string += ("&diet=" + filter.name)
                }
            }
        }
        return string
    }
    
    
    var healthString: String {
           var string = ""
           for filter in model {
               if filter.isSelected {
                   if filter.label == .health {
                       string += ("&health=" + filter.name)
                   }
               }
           }
           return string
       }
       
    
    var numberOfFilters: Int {
        return model.count
    }
    
    
    subscript(index: Int) -> Filter {
        let filter = model[index]
        return filter
    }
    
    
    func toggleSelectedFor(item: Int) {
        model[item].toggleSelected()
        view?.reloadData()
    }
    
    
    func resetPaginationParameters() {
        from = 0
        to = 20
        more = nil
    }
    
    
    func getRecipes(searchQuery: String, completion: @escaping (Result<[Recipe], AppError>) -> ()) {
        view?.startLoading()
        recipeAPI.fetchRecipe(for: searchQuery, from: from, to: to, dietLabels: dietsString, healthLabels: healthString) { [weak self] result in
            guard let self = self else { return }
            self.view?.finishLoading()
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let (recipes, more)):
                self.more = more
                self.from = self.to + 1
                self.to = self.from + 20
                completion(.success(recipes))
            }
        }
    }

    
    func validateSimpleSearchInput(input: String) throws -> String {
        if input.isEmpty && dietsString.isEmpty && healthString.isEmpty {
            throw AppError.noSearchParameters
        }
        return input
    }
    
    
    func validateIngredientsSearchInput(input: [String]) throws -> String {
        guard !input.isEmpty else { throw AppError.noSearchParameters}
        let searchQuery = input.joined(separator: "+")
        return searchQuery
    }
}
