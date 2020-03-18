//
//  ArticlesListUITests.swift
//  TestUITests
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import XCTest

class ArticlesListUITests: UITestBase {
    
    func testListScreen() {
        app.launch()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        let navigationBar = app.navigationBars["Alison Watkins' stimulus plea"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: navigationBar, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
}
