//
//  ArticlesListViewModelTests.swift
//  TestTests
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxTest
import RxCocoa

@testable import Test

class ArticlesListViewModelTests: TestCase {
    
    private let vm: ArticlesListViewModelType = ArticlesListViewModel()
    
    func testFetchArticles() {
        let scheduler = TestScheduler(initialClock: 0)
        scheduler.scheduleAt(TestScheduler.scheduledActionTime) {
            self.vm.inputs.getArticlesContent()
        }
        let correctResults = [
            Recorded.next(TestScheduler.scheduledActionTime,
                          MockService.articles.sorted { $0.timestamp > $1.timestamp })
        ]
        SharingScheduler.mock(scheduler: scheduler) {
            let recorded = scheduler.start({
                self.vm.outputs.articles.elements()
            })
            XCTAssertEqual(recorded.events, correctResults)
        }
    }
    
    
}

