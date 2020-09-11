//
//  RecipeApiTests.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
@testable import PIE

class RecipeApiTests: XCTestCase {
    
    var sut: RecipeAPI!

    override func setUp() {
        super.setUp()
        sut = RecipeAPI()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_createSearchRecipeString() {
        let expectedRecipeUrl = "https://api.edamam.com/search?q=Cookie&app_id=ad437c15&app_key=b272d442e2c75e71bd46e0b1093484df&from=20&to=40&health=vegan&diet=low-fat"
        
        let recipeURL = sut.createSearchRecipeString(searchQuery: "Cookie", from: 20, to: 40, dietLabels: "&health=vegan", healthLabels: "&diet=low-fat")
        
        XCTAssertEqual(expectedRecipeUrl, recipeURL)
    }
    
}
