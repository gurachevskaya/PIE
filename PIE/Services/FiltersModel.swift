//
//  FiltersModel.swift
//  PIE
//
//  Created by Karina on 8/24/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

let filtersModel =   [Filter(name: "vegan", isSelected: false),
                Filter(name: "vegetarian", isSelected: false),
                Filter(name: "peanut-free", isSelected: false),
                //Filter(name: "tree-nut-free", isSelected: false),
                //Filter(name: "alcohol-free", isSelected: false),
                Filter(name: "low-fat", isSelected: false),
                Filter(name: "low-carb", isSelected: false),
                Filter(name: "high-protein", isSelected: false)
]

struct Filter {
    let name: String
    var isSelected: Bool
}

