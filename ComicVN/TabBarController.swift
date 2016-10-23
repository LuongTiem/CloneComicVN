//
//  TabBarController.swift
//  ComicVN
//
//  Created by Enrik on 9/29/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

var tabbarSelectedIndex = 0

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabbarSelectedIndex = item.tag
    }

}
