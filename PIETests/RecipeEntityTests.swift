//
//  RecipeEntityTests.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
import CoreData
@testable import PIE


class CoreDataManagerMock {
//
//    func saveContext() {
//
//    }
//
//    var viewContext: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    var backgroundContext: NSManagedObjectContext {
//        return persistentContainer.newBackgroundContext()
//    }
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "PIE")
//        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
//        container.loadPersistentStores(completionHandler: {(_, error) in
//            XCTAssertNil(error)})
//        return container
//    }()
}


class RecipeEntityTests: XCTestCase {
     
//        private func addRecipe(managedObjectContext: NSManagedObjectContext) {
//            let newRecipe = RecipeEntity(context: managedObjectContext)
//            newRecipe.calories = 220.2
//            newRecipe.label = "Pasta & Chicken"
//            newRecipe.sourse = "Edim doma"
//        }

    override func setUpWithError() throws {
        super.setUp()
//        RecipeEntity.manager = CoreDataManager(container: NSPersistentContainer)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

   
  
}
