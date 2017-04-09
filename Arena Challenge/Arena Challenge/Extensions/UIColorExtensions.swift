//
//  UIColorExtensions.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) {
        self.init(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
    
}

