//
//  RecipeAPI.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation


struct RecipeAPI {
    
    private init() {}
   
    static func fetchRecipe(for searchQuery: String, page: Int, dietLabels: String, healthLabels: String, completion: @escaping (Result<([Recipe], Bool), AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
       
        let fromTo = "from=\(page * 20)&to=\(page * 20 + 20)"
        
        var recipeURL =  "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appkey)&\(fromTo)"
        
        if dietLabels.count != 0 {
            recipeURL = recipeURL + dietLabels
        }

        if healthLabels.count != 0 {
            recipeURL = recipeURL + healthLabels
        }
        
        guard let url = URL(string: recipeURL) else {
            completion(.failure(.badURL(recipeURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkManager.sharedManager.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                if case .tooManyRequests = (appError as AppError) {
                    completion(.failure(.tooManyRequests))
                } else {
                completion(.failure(.networkError(appError)))
                }
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(Recipes.self, from: data)
                    
                    let recipes = results.hits.map { $0.recipe }
                    let more = results.more
                    
                    if recipes.isEmpty {
                        completion(.failure(.noRecipes))
                        return
                    }
                    
                    completion(.success((recipes, more)))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
