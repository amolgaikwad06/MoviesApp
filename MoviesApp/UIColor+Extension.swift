//
//  UIColor+Extension.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/12/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

extension UIColor {
    class func tableViewBackgroundColor() -> UIColor{
        return UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
    }
    class func tableViewSeparatorColor() -> UIColor{
        return UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
    }
    class func navigationBarColor() -> UIColor {
       return UIColor(red: 2.0/255.0, green: 107.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    }
}
