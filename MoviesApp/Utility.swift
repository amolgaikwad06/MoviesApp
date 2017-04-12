//
//  Utility.swift
//  MoviesApp
//
//  Created by Amol Gaikwad on 4/8/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

class Utility {
    static func customizedNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.navigationBarColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 20.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:barFont]
        }
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
