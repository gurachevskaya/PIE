//
//  Double+FormattedTests.swift
//  PIETests
//
//  Created by Karina on 9/5/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
@testable import PIE

class Double_FormattedTests: XCTestCase {

    func test_removeZerosFromEnd() {
        let number: Double = 2.0
        let numberWithoutZeros = number.removeZerosFromEnd()
        XCTAssertEqual(numberWithoutZeros, "2")
    }

    func test_removeZerosFromEnd_WhenNoZerosInTheEnd1() {
        let number: Double = 2.05
        let numberWithoutZeros = number.removeZerosFromEnd()
        XCTAssertEqual(numberWithoutZeros, "2.05")
    }
    
    func test_removeZerosFromEnd_WhenNoZerosInTheEnd2() {
           let number: Double = 2.5
           let numberWithoutZeros = number.removeZerosFromEnd()
           XCTAssertEqual(numberWithoutZeros, "2.5")
       }

    
}
