//
//  ViewTaiVeVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

let kDOCUMENT_DIRECTORY_PATH = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first

class ViewDownload: BaseViewController, UITabBarDelegate {

    @IBOutlet weak var tabbar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tải Về"
        self.tabbar.delegate = self
        
        setupTabbar()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        tabbar.selectedItem = tabbar.items?[tabbarSelectedIndex]
    }
    
    func setupTabbar() {
        let tabDiscovery = UITabBarItem(title: "Khám Phá", image: UIImage(named:"Tabbar Discovery"), tag: 0)
        let tabLatest = UITabBarItem(title: "Mới Nhất", image: UIImage(named:"Tabbar Latest"), tag: 1)
        let tabMostView = UITabBarItem(title: "Xem Nhiều", image: UIImage(named:"Tabbar MostView"), tag: 2)
        let tabCategory = UITabBarItem(title: "Thể Loại", image: UIImage(named:"Tabbar Category"), tag: 3)
        tabbar.items = [tabDiscovery, tabLatest, tabMostView, tabCategory]
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        var index = -1
        switch item.tag {
        case 0: index = 0
        case 1: index = 1
        case 2: index = 2
        case 3: index = 3
        default: index = -1
        }
        
        print(index)
        
        tabbarSelectedIndex = index
        
        if index != -1 {
            let dic: NSDictionary = ["TabIndex": index]
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Tabbar"), object: nil, userInfo: dic as? [AnyHashable: Any])
        }
        
    }
    
    

}
