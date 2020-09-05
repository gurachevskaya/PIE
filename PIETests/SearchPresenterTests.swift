//
//  SearchPresenterTests.swift
//  PIETests
//
//  Created by Karina on 9/5/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
@testable import PIE

class SearchPresenterTests: XCTestCase {
    
    var sut: SearchPresenter!

    override func setUp() {
        super.setUp()
        
        let model = [Filter(name: "vegan", isSelected: true, label: .health),
                                          Filter(name: "vegetarian", isSelected: true, label: .health),
                                          Filter(name: "peanut-free", isSelected: true, label: .health),
                                          Filter(name: "low-fat", isSelected: true, label: .diet),
                                          Filter(name: "low-carb", isSelected: true, label: .diet),
                                          Filter(name: "high-protein", isSelected: true, label: .diet)
                      ]
        sut = SearchPresenter(model: model)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_is_valid_ingredients_search_input() throws {
        let input = ["egg", "milk"]
        XCTAssertNoThrow(try sut.validateIngredientsSearchInput(input: input))
    }
    
    func test_ingredients_search_empty_input() throws {
        let input: [String] = []
        
        let expectedError = AppError.noSearchParameters
        var error: AppError?
        
        XCTAssertThrowsError(try sut.validateIngredientsSearchInput(input: input)) { thrownError in
            error = thrownError as? AppError
        }
        XCTAssertEqual(error, expectedError)
    }
    
    func test_output_validate_ingredients_search_input() throws {
        let input = ["egg", "milk"]
        XCTAssertEqual(try sut.validateIngredientsSearchInput(input: input), "egg+milk")
    }
    
    func test_diet_string_from_model() {
        let expectedString = "&diet=low-fat&diet=low-carb&diet=high-protein"
        XCTAssertEqual(expectedString, sut.dietsString)
    }
    
    func test_health_string_from_model() {
        let expectedString = "&health=vegan&health=vegetarian&health=peanut-free"
        XCTAssertEqual(expectedString, sut.healthString)
    }

    func test_number_of_filters() {
           XCTAssertEqual(6, sut.numberOfFilters)
       }
    
 

}
