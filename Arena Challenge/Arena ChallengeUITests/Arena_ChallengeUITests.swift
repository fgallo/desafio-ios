//
//  Arena_ChallengeUITests.swift
//  Arena ChallengeUITests
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import XCTest

class Arena_ChallengeUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMainFlow() {
        
        // Repository List
        let repositoryTable = app.tables.element
        XCTAssertTrue(repositoryTable.exists)
        
        let repositoryCell = repositoryTable.cells.element(boundBy: 0)
        XCTAssertFalse(repositoryCell.exists)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: repositoryCell, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(repositoryCell.exists)
        
        repositoryCell.tap()
        
        
        // Pull Request List
        let navigationBar = app.navigationBars.element
        XCTAssertTrue(navigationBar.exists)
        
        let backButton = navigationBar.buttons["Back"]
        XCTAssertTrue(backButton.exists)
    
        let pullRequestTable = app.tables.element
        XCTAssertTrue(pullRequestTable.exists)
        
        let pullRequestCell = pullRequestTable.cells.element(boundBy: 0)
        
        expectation(for: exists, evaluatedWith: pullRequestCell, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(pullRequestCell.exists)
        
        backButton.tap()
    }
    
}
