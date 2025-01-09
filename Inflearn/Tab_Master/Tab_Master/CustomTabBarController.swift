//
//  CustomTabBarController.swift
//  Tab_Master
//
//  Created by supaja on 2022/12/30.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .blue
        
    }

}
