//
//  Route.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation

internal enum Route {
    case articles
    
    internal var requestProperties:
        (method: HttpMethod, path: String, query: [String: Any]) {
        switch self {
        case .articles:
            let urlString = "/1/coding_test/13ZZQX/full"
            return (.GET, urlString, [:])
        }
    }
}
