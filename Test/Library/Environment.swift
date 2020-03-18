//
//  Environment.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation

public struct Environment {
    public let apiService: ServiceType
    
    public init(
        apiService: ServiceType = ApiService()) {
        self.apiService = apiService
    }
}
