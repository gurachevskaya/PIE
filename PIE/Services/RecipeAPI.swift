//
//  RecipeAPI.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation


class RecipeAPI {
    
    private var networkManager: NetworkManager
    
    
    init(networkManager: NetworkManager = NetworkManager(session: URLSession.init(configuration: .default))) {
        self.networkManager = networkManager
    }
    

    func fetchRecipe(for searchQuery: String, from: Int, to: Int, dietLabels: String, healthLabels: String, completion: @escaping (Result<([Recipe], Bool), AppError>) -> ()) {
        
        let recipeURL = createSearchRecipeString(searchQuery: searchQuery, from: from, to: to, dietLabels: dietLabels, healthLabels: healthLabels)
        
        guard let url = URL(string: recipeURL) else {
            completion(.failure(.badURL(recipeURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        networkManager.performDataTask(with: request) { (result) in
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
    
    
    func createSearchRecipeString(searchQuery: String, from: Int, to: Int, dietLabels: String, healthLabels: String) -> String {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        let fromTo = "from=\(from)&to=\(to)"
        
        var recipeURL =  "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(AppKey.appId)&app_key=\(AppKey.appkey)&\(fromTo)"
        
        if dietLabels.count != 0 {
            recipeURL = recipeURL + dietLabels
        }
        
        if healthLabels.count != 0 {
            recipeURL = recipeURL + healthLabels
        }
        
        return recipeURL
    }
}
