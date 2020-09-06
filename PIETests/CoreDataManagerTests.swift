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
    
    override func setUpWithError() throws {
        super.setUp()
        sut = CoreDataManager()
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
    
    func test_container() throws {
        let container = sut.persistentContainer
        XCTAssertEqual(container.viewContext.automaticallyMergesChangesFromParent, true)
    }
    
    func test_contextHasChanges() throws {
        let context = sut.persistentContainer.viewContext
//        let favRecipe = RecipeEntity
        
//        context.hasChanges = true
        
//           XCTAssertEqual(container.viewContext.automaticallyMergesChangesFromParent, true)
       }
    
    
    
    
}
