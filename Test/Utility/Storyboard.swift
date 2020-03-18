//
//  Storyboard.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit

public enum Storyboard: String {
    case main
    
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type)
        -> VC {
            guard let vc = UIStoryboard(name: self.rawValue.capitalized, bundle: nil)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC else {
                    fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)")
            }
            return vc
    }
}

extension UIViewController {
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
