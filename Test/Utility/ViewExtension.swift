//
//  ViewExtension.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit

extension UIView {
    public static var defaultReusableId: String {
        return self.description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
    }
}

