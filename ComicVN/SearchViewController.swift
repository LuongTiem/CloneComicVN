//
//  SearchViewController.swift
//  ComicVN
//
//  Created by Enrik on 10/7/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController: UIViewController{

    @IBOutlet weak var searchTableView: UITableView!
    
    var listStories = [Story]()
    var listImages = [UIImage]()
    
    var textSearch: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = textSearch
        
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        
        self.searchTableView.register(UINib(nibName: "CellTableView", bundle: nil), forCellReuseIdentifier: "TableCell")
        
        searchStory()
        
    }
    
    
    func searchStory() {
        let baseURL = "http://comicvn.net/truyentranh/apiv2/timtruyen?keyword="
        
        textSearch = textSearch.replacingOccurrences(of: " ", with: "%20")
        
        let linkSearch = baseURL + textSearch
        
        print(linkSearch)
        
        Alamofire.request(linkSearch).responseJSON { (response) in
            if let json = response.result.value {
                for elementJson in json as! [AnyObject] {
                    let storyData = elementJson as! [String: AnyObject]
                    let story = Story(JSon: storyData)
                    self.listStories.append(story!)
                    self.loadImage(linkImage: (story?.image)!)
                    self.searchTableView.reloadData()
                }
            }
        }
    }
    
    func loadImage(linkImage: String) {
        let baseLink = "http://comicvn.net/static/"
        
        var imageUrl = ""
        
        if linkImage.contains("http") {
            imageUrl = linkImage
        } else {
            imageUrl = baseLink + linkImage
        }
        
        Alamofire.request(imageUrl).responseImage { response in
            if let image = response.result.value {
                self.listImages.append(image)
            }
            
        }

    }
    

}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! CellTableView
        
        cell.im_view.kf.indicatorType = .activity
        
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailStory = mainStoryboard.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
        detailStory.catogory = listStories[indexPath.row].category
        detailStory.story = listStories[indexPath.row]
        
        self.navigationController?.pushViewController(detailStory, animated: true)
        
    }
}
