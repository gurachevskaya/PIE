//
//  FiltersModel.swift
//  PIE
//
//  Created by Karina on 8/24/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

let filtersModel = [Filter(name: "vegan", isSelected: false, label: .health),
                    Filter(name: "vegetarian", isSelected: false, label: .health),
                    Filter(name: "peanut-free", isSelected: false, label: .health),
                    Filter(name: "low-fat", isSelected: false, label: .diet),
                    Filter(name: "low-carb", isSelected: false, label: .diet),
                    Filter(name: "high-protein", isSelected: false, label: .diet)
]


struct Filter: Equatable {
    enum Label: String {
        case diet
        case health
    }
    
    let name: String
    var isSelected: Bool
    let label: Label
    
    
    mutating func toggleSelected() {
        isSelected = !isSelected
    }
}

