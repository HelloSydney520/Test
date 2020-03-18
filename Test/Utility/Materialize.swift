//
//  Materialize.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where Element: EventConvertible {
    
    /**
     Returns an observable sequence containing only next elements from its input
     - seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
     */
    public func elements() -> Observable<Element.Element> {
        return filter { $0.event.element != nil }
            .map { $0.event.element! }
    }
    
    /**
     Returns an observable sequence containing only error elements from its input
     - seealso: [materialize operator on reactivex.io](http://reactivex.io/documentation/operators/materialize-dematerialize.html)
     */
    public func errors() -> Observable<Swift.Error> {
        return filter { $0.event.error != nil }
            .map { $0.event.error! }
    }
}

