//
//  AppEnvironment.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation

public struct AppEnvironment {
    
    fileprivate static var stack: [Environment] = [Environment()]
    
    public static var current: Environment! {
        return stack.last
    }
    
    public static func pushEnvironment(_ env: Environment) {
        stack.append(env)
    }
    
    public static func replaceCurrentEnvironment(_ env: Environment) {
        pushEnvironment(env)
        stack.remove(at: stack.count - 2)
    }

    public static func replaceCurrentEnvironment(
            apiService: ServiceType = AppEnvironment.current.apiService) {
        replaceCurrentEnvironment(Environment(apiService: apiService))
    }
}
