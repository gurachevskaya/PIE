//
//  DetailedRecipePresenterTests.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
import CoreData
@testable import PIE


class DetailedRecipePresenterTests: XCTestCase {
    
    var recipe: Recipe!
    var coreDataManager: CoreDataManagerMock!
    var sut: DetailedRecipePresenter!
    

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManagerMock(recipes: [RecipeEntity(), RecipeEntity()])
        
        let recipe = Recipe(uri: "1", label: "recipe 1", image: "", source: "Edamam", url: "", yield: 2.0, dietLabels: ["low-fat"], healthLabels: ["vegan"], ingredientLines: ["bacon", "cheese"], calories: 200.0, totalWeight: 2.0, totalTime: 2.0)
        
        sut = DetailedRecipePresenter(recipe: recipe, coreDataManager: coreDataManager)
        
    }

    override func tearDown() {
        recipe = nil
        coreDataManager = nil
        sut = nil
        super.tearDown()
    }

    func test_label()  {
        XCTAssertEqual(sut.label, "recipe 1")
    }
    
    func test_calories()  {
        let expectedOutput = 100
           XCTAssertEqual(sut.calories, "\(expectedOutput)")
       }

    func test_servings()  {
           let expectedOutput = "2"
              XCTAssertEqual(sut.servings, "\(expectedOutput)")
          }
    
    func test_source()  {
        let expectedOutput = "on Edamam"
        XCTAssertEqual(sut.source, "\(expectedOutput)")
    }
    
    func test_ingredients() {
        let expectedOutput = "🥣 bacon\n🥣 cheese\n"
        XCTAssertEqual(sut.ingredients, "\(expectedOutput)")
    }
    
    func test_dietsAndHealth() {
       let expectedOutput = "◦low-fat ◦vegan "
        XCTAssertEqual(sut.dietsAndHealth, "\(expectedOutput)")
    }
    
    func test_isInFavourites() {
        XCTAssertEqual(true, sut.isInFavourites)
    }
    
    func test_addInFavourites() {
        sut.addInFavourites()
        XCTAssertTrue(coreDataManager.addRecipeCalled)
    }
    
    func test_deleteFromFavourites() {
           sut.deleteFromFavourites()
           XCTAssertTrue(coreDataManager.deleteRecipeCalled)
       }
    
    func test_openUrl() throws {
        XCTAssertNoThrow(sut.openUrl())
    }
    
    
    
  
}
