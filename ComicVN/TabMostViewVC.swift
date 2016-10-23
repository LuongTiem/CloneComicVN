//
//  TabXemNhieuVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher


class TabMostViewVC: BaseViewController {
    
    @IBOutlet weak var tableMostView: UITableView!
    
    var slideStories = [StoryMostView]()
    var topDownload = [TopDownLoad]()
    var pageIndicator: UIPageControl!
    var collectionView: UICollectionView!
    var subView: UIView!
    
    
     var detail : Detail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Xem Nhiều"
        tableMostView.delegate  = self
        tableMostView.dataSource = self
        tableMostView.prefetchDataSource = self //-- ?
        
        
        tableMostView.register(UINib(nibName :"CellMostView" , bundle : nil), forCellReuseIdentifier: "Cell")
        
        loadData()
        setupCollectionView()
        
        loadSlideStories()
        
//        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        print("App Path: \(dirPaths)")
        
        
        
    }
    
    
    func setupCollectionView() {
        
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionLayout.itemSize = CGSize(width: 176, height: 176)
        collectionLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: tableMostView.frame.width, height: 176), collectionViewLayout: collectionLayout)
        
        collectionView.register(UINib(nibName: "SlideCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SlideCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.bounces = true
        
        collectionView.isScrollEnabled = true
        
        collectionView.isPrefetchingEnabled = true
        
        subView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 176))
        
        pageIndicator = UIPageControl(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        
        pageIndicator.numberOfPages = 10
        
        pageIndicator.currentPage = 0
        
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        
        pageIndicator.backgroundColor = UIColor.clear
        
        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        tableMostView.tableHeaderView = collectionView
        
        tableMostView.addSubview(pageIndicator)
        
        let headerView = tableMostView.tableHeaderView
        
        // contraint pageIndicator
        
        let layoutBottom = NSLayoutConstraint(item: pageIndicator, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let horizontalConstraint = NSLayoutConstraint(item: pageIndicator, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let heightContraint = NSLayoutConstraint(item: pageIndicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
        
        let widthContraint = NSLayoutConstraint(item: pageIndicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        
        NSLayoutConstraint.activate([layoutBottom,horizontalConstraint,heightContraint,widthContraint])
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = 150
        
        pageIndicator.currentPage = Int(collectionView.contentOffset.x / pageWidth)
    }
    
    
    func loadSlideStories() {
        
        let url = URL(string: ManagerData.LINKMOSTVIEW)
        
        Alamofire.request(url!).responseJSON { response in
            
            if let json = response.result.value as? [AnyObject] {
                for elementJson in json {
                    let parJson = elementJson as! [String: AnyObject]
                    let story = StoryMostView.init(Json: parJson)
                    if self.slideStories.count < 10 {
                        self.slideStories.append(story!)
                        self.collectionView.reloadData()
                    }
                }
                
            }
        }
    }
    
    
    
    func loadData(){
 
        DataManager.shareInstance.getTopDownload { (result) in
            self.topDownload = result
            print(result.count)
            self.tableMostView.reloadData()
        }
        
    }
    
   

    
}





extension TabMostViewVC : UITableViewDataSource,UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellMostView
        cell.img?.kf.indicatorType = .activity
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      
        return topDownload.count
        
    }
    
    
    //-- tai su dung cell
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
//        var urls = [URL]()
//        for index in indexPaths {
//            let stringURL = topDownload[index.row].thumbnail
//            let addURL = URL(string: stringURL!)!
//            urls.append(addURL)
//        }
//        ImagePrefetcher(urls: urls).start()
        
    }
    
   
    
}




extension TabMostViewVC : UITableViewDelegate {
    
    //-- sau khi load xong
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        (cell as! CellMostView).img?.kf.cancelDownloadTask() //-- ngung download
        
    }
    
    //-- khi khoi tao view
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        let url = URL(string: topDownload[indexPath.row].thumbnail!)
        _ = (cell as! CellMostView).img?.kf.setImage(with: url, options: [.transition(.fade(1))])
        _ = (cell as! CellMostView).setUpView = topDownload[indexPath.row]
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStory = storyboard?.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
        detailStory.catogory = self.title
        
       // detailStory.storyMost = setup?[indexPath.row].mostview
        self.navigationController?.pushViewController(detailStory, animated: true)
    }
}





extension TabMostViewVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideStories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as! SlideCollectionCell
        //cell.configureCell(story: slideStories[indexPath.item])
        cell.imageSlide.kf.indicatorType = .activity
        return cell
    }
    
    //-- begin
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let stringURL = loadURLImage(url: slideStories[indexPath.item].imageStory!)
        let url = URL(string: stringURL)!
        (cell as! SlideCollectionCell).imageSlide.kf.setImage(with: url , options: [.transition(.fade(1))])
    }
    
    //-- finish 
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! SlideCollectionCell).imageSlide.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailStory = mainStoryBoard.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
        
        detailStory.catogory = ""
        detailStory.storyMost = slideStories[indexPath.item]
        
        navigationController?.pushViewController(detailStory, animated: true)
        
    }
}


