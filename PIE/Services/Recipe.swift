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

//struct Ingredient: Decodable {
//    let foodId: String
//    let quantity: Float
//    let measure: Measure
//    let weight: Float
//    let food: Food
//    let foodCategory: String
//}
//
//struct Measure:Decodable {
//    let label: String
//}
//struct Food: Decodable {
//    let label: String
//}

