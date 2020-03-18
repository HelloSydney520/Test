//
//  ServiceType.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol ServiceType {
    var serverConfig: ServerConfigType { get }
    init(serverConfig: ServerConfigType)
    
    func articles() -> Observable<[Article]>
}

extension ServiceType {
    public func preparedRequest(forRequest originalRequest: URLRequest, query: [String: Any] = [:])
        -> URLRequest {
            
            var request = originalRequest
            guard let URL = request.url else {
                return originalRequest
            }
            
            let headers = self.defaultHeaders
            
            let method = request.httpMethod?.uppercased()
            var components = URLComponents(url: URL, resolvingAgainstBaseURL: false)!
            var queryItems = components.queryItems ?? []
            
            if method == .some("POST") || method == .some("PUT") {
                if request.httpBody == nil {
                    request.httpBody = try? JSONSerialization.data(withJSONObject: query, options: [])
                }
            } else {
                queryItems.append(
                    contentsOf: query
                        .flatMap(queryComponents)
                        .map(URLQueryItem.init(name:value:))
                )
            }
            components.queryItems = queryItems.sorted { $0.name < $1.name }
            request.url = components.url
            
            let currentHeaders = request.allHTTPHeaderFields ?? [:]
            request.allHTTPHeaderFields = currentHeaders.withAllValuesFrom(headers)
            
            return request
    }
    
    public func JSON(request: URLRequest) -> Observable<Any> {
        return URLSession.shared.rx.jsonData(request: request)
    }
    
    public func text(request: URLRequest) -> Observable<(Int, String)> {
        return URLSession.shared.rx.textData(request: request)
    }
    
    public func preparedRequest(forURL url: URL, method: HttpMethod = .GET, query: [String: Any] = [:])
        -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            return self.preparedRequest(forRequest: request, query: query)
    }
    
    private var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json; charset=utf-8"
        return headers
    }
    
    private func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents("\(key)[]", value)
            }
        } else {
            components.append((key, String(describing: value)))
        }
        
        return components
    }
}
