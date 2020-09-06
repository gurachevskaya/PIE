//
//  SearchPresenterTests.swift
//  PIETests
//
//  Created by Karina on 9/5/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
@testable import PIE

class SearchViewMock : NSObject, SimpleSearchView {
    var reloadDataCalled = false
    var startLoadingCalled = false
    var finishLoadingCalled = false
    
    func startLoading() {
        finishLoadingCalled = true
    }
    
    func finishLoading() {
        startLoadingCalled = true
    }
    
    func reloadData() {
        reloadDataCalled = true
    }
}


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
    
    func test_is_valid_simple_search_input() throws {
        let input = "plov"
        XCTAssertNoThrow(try sut.validateSimpleSearchInput(input: input))
       }
    
    func test_is_valid_simple_search_empty_input() throws {
           let input = ""
           XCTAssertNoThrow(try sut.validateSimpleSearchInput(input: input))
          }
    
    func test_simple_search_empty_input() {
        let input = ""
        for (index, _) in sut.model.enumerated() {
            sut.model[index].toggleSelected()
        }
        let expectedError = AppError.noSearchParameters
        var error: AppError?
                
        XCTAssertThrowsError(try sut.validateSimpleSearchInput(input: input)) { thrownError in
            error = thrownError as? AppError
        }
        XCTAssertEqual(error, expectedError)
    }
    
    func test_output_validate_simple_search_input() throws {
           let input = "cookie"
           XCTAssertEqual(try sut.validateSimpleSearchInput(input: input), "cookie")
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
    
    func test_subscript() {
        let expectedFilter = Filter(name: "vegan", isSelected: true, label: .health)
        let filter = sut[0]
        XCTAssertEqual(expectedFilter, filter)
    }
    
    func test_subscript2() {
           let expectedFilter = Filter(name: "vegan", isSelected: false, label: .health)
           let filter = sut[0]
           XCTAssertNotEqual(expectedFilter, filter)
       }
    
    func test_more_is_nil_when_reset() {
        sut.more = false
        sut.resetPaginationParameters()
        XCTAssertNil(sut.more)
    }
    
    func test_current_page_0_when_reset() {
        sut.currentPage = 5
        sut.resetPaginationParameters()
           XCTAssertEqual(0, sut.currentPage)
       }
    
    func test_should_reload_view () {
        let searchViewMock = SearchViewMock()
        sut.view = searchViewMock
        sut.toggleSelectedFor(item: 0)
        XCTAssertTrue(searchViewMock.reloadDataCalled)
    }
    
    func test_toggle() {
        sut.toggleSelectedFor(item: 0)
        XCTAssertEqual(sut.model[0].isSelected, false)
        
    }
}
