//
//  TabKhamPhaVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire


class TabDiscoverVC: BaseViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var disTable: UITableView!
    
    var discover = [Discover]()
    var slideImage = [Contents]()
    
    var collectionView: UICollectionView!
    
    var slideStories = [StoryMostView]()
    
    var pageIndicator: UIPageControl!
    
    var subView: UIView!
    var detail : Detail?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Khám Phá"
        
        disTable.delegate = self
        disTable.dataSource = self
        
        
        disTable.register(UINib(nibName: "DiscoveryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        
        loadData()
        
        
        setupCollectionView()
        
        
        
        DataManager.shareInstance.getDetailCategory { (result) in
            self.detail = result
            
        }        
    }
    
    
    func setupCollectionView() {
        
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionLayout.itemSize = CGSize(width: 176, height: 176)
        collectionLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: disTable.frame.width, height: 176), collectionViewLayout: collectionLayout)
        
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
        
        disTable.tableHeaderView = collectionView
        
        disTable.addSubview(pageIndicator)
        
        let headerView = disTable.tableHeaderView
        
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
    
    
    
    
    func loadData() {
        
        DataManager.shareInstance.getDiscover { (result) in
            
            for (index,elment ) in result.enumerated(){
                
                if index < 4 {
                    self.slideImage.append(elment.listcontents.last!)
                    self.collectionView.reloadData()
                }
                self.discover.append(elment)
                self.disTable.reloadData()
            }
            
        
           
            
            
           
        }
        
}



func loadMoreCategory(_ sender: UIButton) {
//    print(sender.tag)
//    
//    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    
//    let viewCategoryDetail = mainStoryBoard.instantiateViewController(withIdentifier: "categoryDetail") as! ViewCategoryDetail
//    
//    viewCategoryDetail.naviTitle = sender.currentTitle
//    viewCategoryDetail.id = String(sender.tag)
//    
//    navigationController?.pushViewController(viewCategoryDetail, animated: true)
    
}
}

extension TabDiscoverVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discover.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = disTable.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! DiscoveryTableViewCell
        
        cell.delegate = self
        cell.discover = discover[indexPath.row]
        
        return cell
        
    }
}

extension  TabDiscoverVC: PushStoryDelegate {
    func pushStory(story: Detail) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailStory = mainStoryBoard.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
        
        detailStory.getData = story
        navigationController?.pushViewController(detailStory, animated: true)
    }
}

extension TabDiscoverVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as! SlideCollectionCell
        
        cell.imageSlide.kf.indicatorType = .activity
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let urlString = slideImage[indexPath.item].thumbnail
        let url = URL(string: urlString!)!
        (cell as! SlideCollectionCell).imageSlide.kf.setImage(with: url , options: [.transition(.flipFromLeft(0.5))])
        (cell as! SlideCollectionCell).slideImage = slideImage[indexPath.item]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        (cell as! SlideCollectionCell).imageSlide.kf.cancelDownloadTask()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailStory = mainStoryBoard.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
        detailStory.getData = detail
        
        navigationController?.pushViewController(detailStory, animated: true)
        
    }
}

