//
//  UIStoryboardExtensions.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    @nonobjc static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var repositoriesViewController: RepositoriesViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "RepositoriesViewController") as? RepositoriesViewController else {
            fatalError("RepositoriesViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
}
