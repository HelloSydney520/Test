//
//  ArticlesListViewModel.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ArticlesListViewModelInputs {
    func getArticlesContent()
}

public protocol ArticlesListViewModelOutputs {
    var articles: Observable<Event<[Article]>> { get }
}

public protocol ArticlesListViewModelType {
    var inputs: ArticlesListViewModelInputs { get }
    var outputs: ArticlesListViewModelOutputs { get }
}

public final class ArticlesListViewModel:
ArticlesListViewModelInputs, ArticlesListViewModelOutputs, ArticlesListViewModelType {
    
    public init() {
        self.articles = self.getArticlesContentPublishSubject.asObservable()
            .flatMapLatest {
                // Observables terminate whenever they receive error or completed events.
                // Termination means an Observable subscription won’t receive any new message.
                // To prevent this use materialize operator.
                return AppEnvironment.current.apiService.articles().materialize()
            }
    }
    
    private var getArticlesContentPublishSubject: PublishSubject<Void> = PublishSubject()
    public func getArticlesContent() {
        self.getArticlesContentPublishSubject.onNext(())
    }
    
    public let articles: Observable<Event<[Article]>>

    public var inputs: ArticlesListViewModelInputs { return self }
    public var outputs: ArticlesListViewModelOutputs { return self }
}
