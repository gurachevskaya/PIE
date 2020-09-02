//
//  Recipe.swift
//  PIE
//
//  Created by Karina on 8/21/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

struct Recipes: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let uri: String
    let label : String
    let image : String
    let source: String
    let url: String
    let yield: Double
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredientLines: [String]
    let calories: Double
    let totalWeight: Double
    let totalTime: Double
}


