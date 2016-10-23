//
//  BaseViewController.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SWRevealViewControllerDelegate, UISearchBarDelegate{
    
    var menuBarButton: UIBarButtonItem!
    var searchBar: UISearchBar!
    var tapOutSearchBar: UIGestureRecognizer!
    var tapGesture: UIGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBarButton = UIBarButtonItem(image: UIImage(named:"Menu Icon"), style: .plain, target: self, action: nil)
        
        self.revealViewController().delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openMenu()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tapOutSearchBar = UITapGestureRecognizer(target: self.searchBar, action: #selector(resignFirstResponder))
        self.view.addGestureRecognizer(tapOutSearchBar)
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-20, height: 20)

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.removeGestureRecognizer(tapOutSearchBar)
        searchBar.frame = CGRect(x: 0, y: 0, width: 120, height: 20)
  
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(searchBar.text)
        let searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        
        searchViewController.textSearch = searchBar.text
        
        self.navigationController?.pushViewController(searchViewController, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        
        
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        
        
        navigationItem.leftBarButtonItem = menuBarButton
        navigationItem.rightBarButtonItem = searchBarItem
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        navigationController?.navigationBar.barTintColor = UIColor(red: 74/225, green: 144/255, blue: 226/155, alpha: 1.0)
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        searchBar.tintColor = UIColor.gray
    }
    
    func openMenu() {
        if revealViewController() != nil {
            menuBarButton.target = revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = REAR_VIEW_WIDTH
            revealViewController().frontViewShadowOpacity = 0
            revealViewController().draggableBorderWidth = 100
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        }
        
    }
    
//    func revealController(_ revealController: SWRevealViewController!, didMoveTo position: FrontViewPosition) {
//        print("Hello")
//        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeMenu))
//        
//        if case .right = position {
//            view.addGestureRecognizer(tapGesture)
//        } else {
//            view.removeGestureRecognizer(tapGesture)
//        }
//
//    }
//    
//    func closeMenu() {
//        revealViewController().setFrontViewPosition(FrontViewPosition.left, animated: true)
//    }
    //-- check link URL
    func loadURLImage(url: String) -> String {
        var stringURL = ""
        let baseLink = "http://comicvn.net/static/"
        
        if (url.contains("http")) {
            stringURL = url
        } else {
            stringURL = baseLink + url
        }
        
        return stringURL
    }
}
