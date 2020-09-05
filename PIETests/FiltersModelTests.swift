//
//  FiltersModelTests.swift
//  PIETests
//
//  Created by Karina on 9/5/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
@testable import PIE


class FiltersModelTests: XCTestCase {
    
    var sut: Filter!
    
    override func setUp() {
        super.setUp()
        sut = Filter(name: "vegetarian", isSelected: false, label: .health)
    }
    
    override func tearDown() {
           sut = nil
           super.tearDown()
       }
    
    func test_toggle() {
        sut.toggleSelected()
        XCTAssertEqual(sut.isSelected, true)
    }
    
}
