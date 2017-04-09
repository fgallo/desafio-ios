//
//  UIViewExtensions.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 09/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import UIKit

extension UIView {
    
    func addDropShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 1.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        clipsToBounds = false
    }
    
}
