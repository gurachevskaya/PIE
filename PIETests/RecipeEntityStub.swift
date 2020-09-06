//
//  RecipeEntityStub.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation
import CoreData
@testable import PIE

class RecipeEntityStub: RecipeEntity {
    override var label: String? {
        set {}
        get {
            return "cookie"
        }
    }
    override var image: String? {
        set {}
        get {
            return ""
        }
    }
    override var source: String? {
        set {}
        get {
            return ""
        }
    }
    override var date: Date? {
        set {}
        get {
            return Date.init()
        }
    }
    override var dietLabels: [String]? {
        set {}
        get {
            return []
        }
    }
    override var healthLabels: [String]? {
        set {}
        get {
            return []
        }
    }
    override var ingredientLines: [String]? {
        set {}
        get {
            return []
        }
    }
    override var calories: Double{
           set {}
           get {
            return 1.0
           }
       }
    override var totalTime: Double {
        set {}
        get {
            return 1.0
        }
    }
    override var totalWeight: Double {
        set {}
        get {
            return 1.0
        }
    }
    override var uri: String? {
        set {}
        get {
            return ""
        }
    }
    override var url: String? {
        set {}
        get {
            return ""
        }
    }
    override var yield: Double {
        set {}
        get {
            return 1.0
        }
    }
    
}
