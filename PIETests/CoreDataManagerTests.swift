//
//  CoreDataManagerTests.swift
//  PIETests
//
//  Created by Karina on 9/5/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
import CoreData
@testable import PIE

class CoreDataManagerTests: XCTestCase {
    
    var sut: CoreDataManager!
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PIE", managedObjectModel: NSManagedObjectModel.mergedModel(from: [Bundle.main])!)
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSSQLiteStoreType )
            
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()
    
    override func setUpWithError() throws {
        super.setUp()
        sut = CoreDataManager(container: mockPersistantContainer)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func test_viewContext_notNil() throws {
        let context = sut.viewContext
        XCTAssertNotNil(context)
    }
    
    func test_backgroundContext_notNil() throws {
        let context = sut.backgroundContext
        XCTAssertNotNil(context)
    }
    
    func test_checkEmpty() {
        let rows = sut.fetchRecipes()
        XCTAssertTrue(rows.isEmpty)
    }
    
    func test_add() {
        let rowsBefore = sut.fetchRecipes()
        XCTAssertTrue(rowsBefore.isEmpty)
        
        for i in 1...10 {
            let recipe = Recipe(uri: "\(i)", label: "recipe \(i)", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)
            XCTAssertNotNil(sut.addRecipe(recipe:recipe))
        }
        let rowsAfter = sut.fetchRecipes()
        XCTAssertEqual(rowsAfter.count, 10)
    }
    
    func test_deleteAll() {
        for i in 1...10 {
            let recipe = Recipe(uri: "\(i)", label: "recipe \(i)", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)
            XCTAssertNotNil(sut.addRecipe(recipe:recipe))
        }
        let rowsBefore = sut.fetchRecipes()
        XCTAssertEqual(rowsBefore.count, 10)
        
        sut.deleteAllRecipes()
        let rowsAfter = sut.fetchRecipes()
        XCTAssertTrue(rowsAfter.isEmpty)
    }
    
    func test_delete() {
        for i in 1...10 {
            let recipe = Recipe(uri: "\(i)", label: "recipe \(i)", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)
            XCTAssertNotNil(sut.addRecipe(recipe:recipe))
        }
        let rowsBefore = sut.fetchRecipes()
        XCTAssertEqual(rowsBefore.count, 10)
        
        sut.deleteRecipe(recipe: Recipe(uri: "1", label: "recipe 1", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0))
        
        let rowsAfter = sut.fetchRecipes()
        XCTAssertEqual(rowsAfter.count, 9)
    }

    func test_delete_whenNoRecipe() {
        
        let recipe = Recipe(uri: "2", label: "recipe 2", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)
        XCTAssertNotNil(sut.addRecipe(recipe:recipe))
        let rowsBefore = sut.fetchRecipes()
        XCTAssertEqual(rowsBefore.count, 1)
        
        sut.deleteRecipe(recipe: Recipe(uri: "1", label: "recipe 1", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0))
        
        let rowsAfter = sut.fetchRecipes()
        XCTAssertEqual(rowsAfter.count, 1)
    }
    
    func test_add_whenInFavourite() {
        let recipe1 = Recipe(uri: "2", label: "recipe 2", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)
        XCTAssertNotNil(sut.addRecipe(recipe:recipe1))
        let rowsBefore = sut.fetchRecipes()
        XCTAssertEqual(rowsBefore.count, 1)
        
        let recipe2 = Recipe(uri: "2", label: "recipe 2", image: "", source: "", url: "", yield: 2.0, dietLabels: [], healthLabels: [], ingredientLines: [], calories: 2.0, totalWeight: 2.0, totalTime: 2.0)
        XCTAssertNotNil(sut.addRecipe(recipe:recipe2))
        let rowsAfter = sut.fetchRecipes()
        XCTAssertEqual(rowsAfter.count, 1)
        
    }
    
   
    
}
