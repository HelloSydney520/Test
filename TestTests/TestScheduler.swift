//
//  TestScheduler.swift
//  TestTests
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import RxSwift
import RxTest

extension TestScheduler {
    func record<O: ObservableConvertibleType>(source: O) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(TestScheduler.Defaults.disposed) {
            disposable.dispose()
        }
        return observer
    }
    
    public static let scheduledActionTime = 210
}

