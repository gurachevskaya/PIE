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
    
    static func fetchRecipe(for searchQuery: String,
                            completion: @escaping (Result<[Recipe], AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        let recipeURL =  "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appkey)&from=0&to=50"
        
        guard let url = URL(string: recipeURL) else {
            completion(.failure(.badURL(recipeURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkManager.sharedManager.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(Recipes.self, from: data)
                    
                    let recipes = results.hits.map { $0.recipe }
                    
                    completion(.success(recipes))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
