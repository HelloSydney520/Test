//
//  MockService.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift

public struct MockService: ServiceType {
    // mock data
    public static let article1 = Article(title: "Alison Watkins' stimulus plea",
                                         abstract: """
Coca-Cola Amatil's fortunes show the pandemic has spread through the economy.\
 CEO Alison Watkins wants government help to target those hit hardest.
""",
                                         writer: "James Thomson",
                                         url: "https://www.google.com",
                                         timestamp: 1584450000000,
                                         thumbnail: Thumbnail(width: 300, height: 200, url: "placeholder"))
    public static let article2 = Article(title: "John Gandel is Australia's first Bombardier 7500 owner",
                                         abstract: "The new Bombardier can match the Gulfstream 650 and fly between Australia and the US non-stop.",
                                         writer: "Joe Aston",
                                         url: "https://www.google.com",
                                         timestamp: 1584449340000,
                                         thumbnail: nil)
    public static let article3 = Article(title:"Malls under pressure from 'social distancing'",
                                         abstract: """
The potential of partial mall closures – while leaving open vital services such as\
 supermarkets, pharmacies and clinics – has increased.
""",
                                         writer: "Nick Lenaghan",
                                         url: "https://www.google.com",
                                         timestamp: 1584433837000,
                                         thumbnail: Thumbnail(width: 300, height: 200, url: "placeholder"))
    public static let article4 = Article(title:"Change central banks' rules or face total global liquidation",
                                         abstract: """
The danger now is that the deepening global recession will morph into something more intractable:\
 a deflationary depression with a wave of defaults that effectively breaks the capitalist system as we know it, writes Ambrose Evans-Pritchard.
""",
                                         writer: "Ambrose Evans-Pritchard",
                                         url: "https://www.google.com",
                                         timestamp: 1584417688000,
                                         thumbnail: Thumbnail(width: 300, height: 200, url: "placeholder"))
    
    public static let articles = [
        article1, article2, article3, article4
    ]
    
    public let serverConfig: ServerConfigType
    
    public init(serverConfig: ServerConfigType = ServerConfig.dev) {
        self.serverConfig = serverConfig
    }
    
    public func articles() -> Observable<[Article]> {
        return Observable.deferred {
            return .just(MockService.articles.sorted {
                $0.timestamp > $1.timestamp })
        }
    }
    
}

