//
//  DetailTruyenVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewDetailStory: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    
    var getData : Detail?
    var id: String!
    var catogory: String!
    var chapter = [ChapterStory]()
    var chap : ChapterStory?
    var storyMost :StoryMostView?
    var storyNewest : StoryNewest?
    
    var story: Story?
    
    @IBOutlet var table_view: UITableView!
    
    @IBOutlet var scroll_image: UIScrollView!
    var imageView = UIImageView()
    
    @IBOutlet var nameManga: UILabel!
    @IBOutlet var countView: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var descriptionStorys: UITextView!
    
    var first = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_view.delegate = self
        table_view.dataSource = self
        scroll_image.delegate = self
        
      
        
        table_view.register(UINib(nibName: "CellChapter", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        scroll_image.contentSize =  CGSize(width:imageView.frame.size.width, height:imageView.frame.size.height + 20)
        scroll_image.addSubview(imageView)
        loadData()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = getData?.chapters.count{
            return count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellChapter
        cell.setUpViews = getData?.chapters[indexPath.row]
        return cell
    }

    func loadData() {
        let url = URL(string: "http://st.comicvn.net/static/files/uploads/files/b%C3%ACa_truy%E1%BB%87n/NTGH_MeDep.jpg")!
        imageView.kf.setImage(with: url , options: [.transition(.fade(1))])
        nameManga.text = getData?.name
        if let views = getData?.view {
            countView.text = String(views)
        }
        descriptionStorys.text  = getData?.description
        category.text = ""
        
    }
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewRead = storyboard?.instantiateViewController(withIdentifier: "viewRead") as! ViewReadStory
//        viewRead.readChap = chapter[indexPath.row]
        viewRead.listChapterStory = getData?.chapters
        viewRead.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewRead, animated: true)
    }
    
    
    
}
