//
//  RecipesPresenterTests.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
import CoreData
@testable import PIE

class RecipeViewMock: NSObject, RecipeView {
    var reloadDataCalled = false
    
    func reloadData() {
        reloadDataCalled = true
    }
}

class NetworkManagerMock: NetworkManager {
    
    
}


class RecipePresenterTests: XCTestCase {
    
    var sut: RecipesPresenter!
    
    let notEmptyCoreDataManagerMock = CoreDataManagerMock(recipes: [RecipeEntity(), RecipeEntity()])
    
    let emptyCoreDataManagerMock = CoreDataManagerMock(recipes: [])
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_isEmpty_whenNoRecipesInCoreManager() {
        sut = RecipesPresenter(coreDataManager: emptyCoreDataManagerMock)
        XCTAssertEqual(sut.isEmpty, true)
    }
    
    func test_isEmpty_whenRecipesInCoreManager() {
        sut = RecipesPresenter(coreDataManager: notEmptyCoreDataManagerMock)
        XCTAssertEqual(sut.isEmpty, false)
    }
    
    func test_numberOfRecipes() {
        sut = RecipesPresenter()
        sut.recipes = [Recipe(uri: "1", label: "recipe 1", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)]
        
        XCTAssertEqual(sut.numberOfRecipes, 1)
    }
    
    func test_deleteAllRecipes() {
        sut = RecipesPresenter(coreDataManager: notEmptyCoreDataManagerMock)
        sut.recipes = [Recipe(uri: "1", label: "recipe 1", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)]
        
        let view = RecipeViewMock()
        sut.view = view
        
        sut.removeAllRecipes()
        XCTAssertTrue(notEmptyCoreDataManagerMock.deleteAllRecipesCalled)
        XCTAssertTrue(view.reloadDataCalled)
        XCTAssertTrue(sut.recipes.count == 0)
    }
    
    func test_createRecipe() {
        sut = RecipesPresenter()
        let recipeEntity = RecipeEntityStub()
        
        let recipe = sut.createRecipeWith(recipeEntity: recipeEntity)
        
        XCTAssertTrue(recipe.label == "cookie")
        XCTAssertTrue(recipe.source == "Edamam")
        XCTAssertTrue(recipe.image == "image")
   
    }
    
    func test_createRecipe_whenEmptyEntity() {
        sut = RecipesPresenter()
        let recipeEntity = RecipeEntityEmptyStub()
        
         let recipe = sut.createRecipeWith(recipeEntity: recipeEntity)
        XCTAssertEqual(recipe.label, "")
        XCTAssertEqual(recipe.source, "")
    }

}
