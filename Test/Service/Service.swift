//
//  Service.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation
import RxSwift

public struct ApiService: ServiceType {
    
    public let serverConfig: ServerConfigType
    
    public init(
        serverConfig: ServerConfigType = ServerConfig.dev) {
        self.serverConfig = serverConfig
    }
    
    public func articles() -> Observable<[Article]> {
        let route = Route.articles
        return articlesResponse(route: route)
    }
    
    private func requestJSON(route: Route) -> Observable<Any> {
        let properties = route.requestProperties
        guard let URL = URL(string: properties.path, relativeTo: self.serverConfig.apiBaseUrl as URL) else {
            fatalError(
                "URL(string: \(properties.path), relativeToURL: \(self.serverConfig.apiBaseUrl)) == nil"
            )
        }
        let httpRequest = preparedRequest(forURL: URL, method: properties.method, query: properties.query)
        return JSON(request: httpRequest)
    }
    
    private func articlesResponse(route: Route) -> Observable<[Article]> {
        return requestJSON(route: route)
            .observeOn(Dependencies.sharedDependencies.backgroundWorkScheduler)
            .map{ json in
                if let dict = json as? [String: Any],
                    let assets = dict["assets"] as? [[String: Any]] {
                    return assets.map {
                        let title = $0["headline"] as? String ?? ""
                        let abstract = $0["theAbstract"] as? String ?? ""
                        let writer = $0["byLine"] as? String ?? ""
                        let url = $0["url"] as? String ?? ""
                        let timestamp = $0["timeStamp"] as? Int64 ?? 0
                        var thumbnail: Thumbnail?
                        if let images = $0["relatedImages"] as? [[String: Any]] {
                            thumbnail = images.map {
                                let width = $0["width"] as? Int ?? 0
                                let height = $0["height"] as? Int ?? 0
                                let url = $0["url"] as? String ?? ""
                                return Thumbnail(width: width, height: height, url: url)
                            }.filter {
                                $0.width != 0 && $0.height != 0 && !$0.url.isEmpty
                            }.sorted {$0.width * $0.height < $1.width * $1.height}
                                .first
                        }
                        return Article(title: title, abstract: abstract, writer: writer, url: url, timestamp: timestamp, thumbnail: thumbnail)
                    }.sorted { $0.timestamp > $1.timestamp }
                }
                return []
        }
        .observeOn(Dependencies.sharedDependencies.mainScheduler)
    }
}

