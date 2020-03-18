//
//  ArticlesListControllerTests.swift
//  TestTests
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit

@testable import Test

class ArticlesListControllerTests: TestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testView_defaultState() {
        let controller = Storyboard.main.instantiate(ArticlesListViewController.self)
        startSnapshotTesting(controller: controller) { vc in
            vc.viewModel.inputs.getArticlesContent()
        }

    }
    
}
