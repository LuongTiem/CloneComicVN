//
//  TabMoiNhatVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class TabNewestVC: BaseViewController{
    
    @IBOutlet weak var tableVc: UITableView!
    
    var collectionView: UICollectionView!
    
    var slideStories = [TopNew]()
    
    var pageIndicator: UIPageControl!
    
    var subView: UIView!
    
     var detail : Detail?
    
    var listTopNew =  [TopNew]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mới Update"
        tableVc.delegate  = self
        tableVc.dataSource = self
        tableVc.prefetchDataSource = self
        
        tableVc.register(UINib(nibName :"NewestCell" , bundle : nil), forCellReuseIdentifier: "Cell")
        
        setupCollectionView()
        
        DataManager.shareInstance.getTopNew { (result) in
            self.listTopNew = result
            self.tableVc.reloadData()
            let daoArr = result.reversed()
            
            for element in daoArr {
                if (self.slideStories.count < 10) {
                    self.slideStories.append(element)
                    self.collectionView.reloadData()
                }
                
            }
            
            
            
        }
        
        
        
        DataManager.shareInstance.getDetailCategory { (result) in
            self.detail = result
           
        }
        
        
    }
    
    
    func setupCollectionView() {
        
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionLayout.itemSize = CGSize(width: 176, height: 176)
        collectionLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: tableVc.frame.width, height: 176), collectionViewLayout: collectionLayout)
        
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
        
        tableVc.tableHeaderView = collectionView
        
        tableVc.addSubview(pageIndicator)
        
        let headerView = tableVc.tableHeaderView
        
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
    
}



extension TabNewestVC : UITableViewDataSource,UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewestCell
        cell.im_view.kf.indicatorType = .activity
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTopNew.count
    }
    
    //--
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]){
        var urls = [URL]()
        for indexPath in indexPaths {
            let stringURL = listTopNew[indexPath.row].thumbnail
            let addURL = URL(string: stringURL!)!
            urls.append(addURL)
        }
        ImagePrefetcher(urls: urls).start()
    }
    
}


extension TabNewestVC : UITableViewDelegate {
    
    
    //-- load finish
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! NewestCell).im_view.kf.cancelDownloadTask()
    }
    //--
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let url = URL(string: loadURLImage(url: listTopNew[indexPath.row].thumbnail!))!
        _ = (cell as! NewestCell).im_view.kf.setImage(with: url, options: [.transition(.fade(1))])
        _ = (cell as! NewestCell).setupCell = listTopNew[indexPath.row]
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStory = storyboard?.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
        detailStory.catogory = self.title
         detailStory.getData = detail
        self.navigationController?.pushViewController(detailStory, animated: true)
    }
}










extension TabNewestVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideStories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as! SlideCollectionCell
        cell.imageSlide.kf.indicatorType = .activity
        return cell
    }
    
    //-- begin
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let urlString = loadURLImage(url: slideStories[indexPath.item].thumbnail!)
        let url = URL(string: urlString)!
        
        (cell as! SlideCollectionCell).imageSlide.kf.setImage(with: url, options: [.transition(.flipFromLeft(0.5))])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailStory = mainStoryBoard.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory

         detailStory.getData = detail
        
        navigationController?.pushViewController(detailStory, animated: true)
        
    }
}



