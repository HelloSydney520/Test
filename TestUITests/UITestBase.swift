//
//  UITestBase.swift
//  TestUITests
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import XCTest
import UIKit
class UITestBase: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments.append("--uitesting")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
}

