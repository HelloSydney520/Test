//
//  Observable.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableConvertibleType {
    public func observerForUI() -> Observable<Element> {
        return self.asObservable().observeOn(MainScheduler.instance)
    }
}
