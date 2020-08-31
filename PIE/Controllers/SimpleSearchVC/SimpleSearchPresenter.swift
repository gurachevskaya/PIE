//
//  SimpleSearchPresenter.swift
//  PIE
//
//  Created by Karina on 8/28/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

//protocol SimpleSearchPresenter: class {
//    var view: SimpleSearchView? { get set }
//    var numberOfFilters: Int { get }
//
//
//}


final class SimpleSearchPresenter {
    
    weak var view: SimpleSearchView?
    
//    private var model = filtersModel
    
   
      var numberOfFilters: Int {
          return filtersModel.count
      }
    
    subscript(index: Int) -> Filter {
       // ???nil
        let filter = filtersModel[index]
        return filter
    }
    
    
    func toggleSelectedFor(item: Int) {
        filtersModel[item].toggleSelected()
    }
    
    
    func getRecipes(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError>) -> ()) {
        
        var dietsString = ""
        var healthString = ""
             
        for filter in filtersModel {
            if filter.isSelected {
                if filter.label == .diet {
                    dietsString += ("&diet=" + filter.name)
                } else {
                    healthString += ("&health=" + filter.name)
                }
            }
        }
    
        if searchQuery.count == 0 && dietsString.count == 0 && healthString.count == 0 {
            completion(.failure(.noSearchParameters))
            return
        }
        
        RecipeAPI.fetchRecipe(for: searchQuery, dietLabels: dietsString, healthLabels: healthString) { result in
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let recipes):
                completion(.success(recipes))
            }
        }
    }
        
}
