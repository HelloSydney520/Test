//
//  Dictionary.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation

public extension Dictionary {
    func withAllValuesFrom(_ other: Dictionary) -> Dictionary {
        var result = self
        other.forEach { result[$0] = $1 }
        return result
    }
}

