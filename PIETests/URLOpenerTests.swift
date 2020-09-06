//
//  URLOpenerTests.swift
//  PIETests
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import XCTest
@testable import PIE

class ApplicationMock: URLOpenerProtocol {
    var openCalled = false
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
         openCalled = true
    }
}

class URLOpenerTests: XCTestCase {
    
    var sut: URLOpener!
    var application: ApplicationMock!

    override func setUp()  {
        super.setUp()
        application = ApplicationMock()
        sut = URLOpener(application: application)
    }

    override func tearDown() {
        application = nil
        sut = nil
        super.tearDown()
    }

    func test_open() {
        sut.openURL(url: "String")
        XCTAssertTrue(application.openCalled)
    }
    
    func test_open_whenNilUrl() {
           sut.openURL(url: "")
           XCTAssertTrue(!application.openCalled)
       }
    
    func test_init() {
        sut = URLOpener()
        XCTAssertNotNil(sut.application)
    }
}
