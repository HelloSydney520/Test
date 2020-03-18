//
//  ServiceConfig.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation

public protocol ServerConfigType {
    var apiBaseUrl: URL { get }
    var environment: EnvironmentType { get }
}

public enum EnvironmentType: String {
    public static let allCases: [EnvironmentType] = [.dev, .staging, .production]

    case dev = "Development"
    case staging = "Staging"
    case production = "Production"
}

public struct ServerConfig: ServerConfigType {
    public fileprivate(set) var apiBaseUrl: URL
    public fileprivate(set) var environment: EnvironmentType
    
    public init(apiBaseUrl: URL,
                environment: EnvironmentType = .dev) {
        self.apiBaseUrl = apiBaseUrl
        self.environment = environment
    }
    
    public static let dev: ServerConfigType = ServerConfig(
        apiBaseUrl: URL(string: Secrets.ApiEndpoint.dev)!,
        environment: EnvironmentType.dev
    )
    
    public static let staging: ServerConfigType = ServerConfig(
        apiBaseUrl: URL(string: Secrets.ApiEndpoint.staging)!,
        environment: EnvironmentType.staging
    )
    
    public static let production: ServerConfigType = ServerConfig(
        apiBaseUrl: URL(string: Secrets.ApiEndpoint.production)!,
        environment: EnvironmentType.production
    )
}
