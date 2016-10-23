//
//  ViewDocTruyen.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class ViewReadStory: UIViewController,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {

    
    @IBOutlet weak var layoutCollectionView: UICollectionViewFlowLayout!
    @IBOutlet weak var pageNumber: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var isTapScreen:Bool = true
    var listImage = [String]()
    var pageNow :Int = 0
    var titleChap:String!
    var listChapterStory: [Chapter]?
    var readChap : ChapterStory?
    var tapGesture : UITapGestureRecognizer! = nil
    var bottom : NSLayoutConstraint!
    var heightCell : CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.prefetchDataSource = self
        collectionView.delegate  = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "CellReadBook", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.white
        layoutCollectionView.scrollDirection = .horizontal
        layoutCollectionView.minimumLineSpacing = 0
        layoutCollectionView.minimumInteritemSpacing = 0
        self.automaticallyAdjustsScrollViewInsets = false
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        //loadData(IDChapter: (readChap?.id_chapter)!)
        
        title = readChap?.chapter_name
        navigationItem.leftBarButtonItem  = UIBarButtonItem(image: #imageLiteral(resourceName: "Back.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(backBarItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Literature") , style: .plain, target: self, action: #selector(checkShowListChapter))
        
        
        showListChapter()
        
        loadData()
        
        
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != nil && touch.view!.isDescendant(of: self.addNewTableView) {
            return false
        }
        return true
    }
    
    
    var addNewTableView : UITableView!
    func showListChapter(){
        addNewTableView = UITableView()
        addNewTableView.isHidden = true
        self.view.addSubview(addNewTableView)
        
        //-- contraint
        self.addNewTableView.translatesAutoresizingMaskIntoConstraints  = false
        
        let top = NSLayoutConstraint(item: addNewTableView, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .top, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: addNewTableView, attribute: .trailing, relatedBy: .equal, toItem: collectionView, attribute: .trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: addNewTableView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width/2)
        bottom = NSLayoutConstraint(item: addNewTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.height/2)
        
        let contraints = [top,right,width,bottom]
        
        self.view.addConstraints(contraints as! [NSLayoutConstraint])
        addNewTableView.delegate = self
        addNewTableView.dataSource = self
        addNewTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        
    }
    
    func checkShowListChapter(){
        let heightCell = CGFloat(44 * (listChapterStory?.count)!)
        print(heightCell)
        if heightCell >= self.view.frame.height{
            bottom.constant = self.view.frame.height
        }else{
            bottom.constant = heightCell
        }
        if(addNewTableView.isHidden == true) {
            
            UIView.transition(with: self.addNewTableView, duration: 0.5, options: .transitionCurlDown, animations: nil, completion: nil)
            
        }else{
            UIView.transition(with: self.addNewTableView, duration: 0.3, options: .transitionCurlUp, animations: nil, completion: nil)
            
        }
        addNewTableView.isHidden = !addNewTableView.isHidden
        
    }
    func backBarItem ()  {
        self.navigationController!.popViewController(animated: true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutCollectionView.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layoutCollectionView.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: pageNow, section: 0)
        if let currentCell = collectionView.cellForItem(at: indexPath) as? CellReadBook {
            currentCell.configureImage()
        }
    }
    
    
    func tapScreen(){
        if isTapScreen {
            pageNumber.isHidden = true
            UIApplication.shared.isStatusBarHidden = true
            navigationController?.setNavigationBarHidden(true, animated: false)
            addNewTableView.isHidden = true
            view.updateFocusIfNeeded()
            isTapScreen = !isTapScreen
        }else{
            UIApplication.shared.isStatusBarHidden = false
            navigationController?.setNavigationBarHidden(false, animated: false)
            pageNumber.isHidden = false
            view.updateFocusIfNeeded()
            isTapScreen = true
        }
    }
    
    
    func loadData(){
        
        DataManager.shareInstance.getChapterReadBook { (result)  in
            self.listImage = result.image!
            self.navigationItem.title = result.name
            self.pageNumber.text = "\(self.pageNow + 1) - \(self.listImage.count)"
            self.collectionView.reloadData()
        }
    }
    
    
    
    //--  khi xoay man hinh
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation.isLandscape)
        collectionView.collectionViewLayout.invalidateLayout() //-- update  lai layout
        //-- khi scroll den item nao thi update lai
        let indexPath = IndexPath(item: pageNow, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.layoutCollectionView.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
            
            
            if let currentCell = self.collectionView.cellForItem(at: indexPath) as? CellReadBook {
                currentCell.configureImage()
            }
            self.collectionView.reloadData()
        }
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageNow = pageNumber
        self.pageNumber.text = "\(pageNumber + 1) - \(self.listImage.count)"
    }
    
    
    
}


extension ViewReadStory : UICollectionViewDelegate {
    //-- begin
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let url = URL(string: listImage[indexPath.item])!
        (cell as! CellReadBook).imageViews.kf.setImage(with: url, options: [.transition(.fade(1))])
    }
    //--
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! CellReadBook).imageViews.kf.cancelDownloadTask()
    }
    
}

extension ViewReadStory : UICollectionViewDataSource,UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellReadBook
        cell.imageViews.kf.indicatorType = .activity

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]){
        var urls = [URL]()
        for indexPath in indexPaths {
            let url = URL(string: listImage[indexPath.item])
            if url == nil {
                return
            }else{
                urls.append(url!)
            }
        }
        
        ImagePrefetcher(urls: urls).start()
    }
    
}


extension ViewReadStory : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listChapterStory!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = listChapterStory?[indexPath.row].name
        
        heightCell = CGFloat((listChapterStory?.count)!) * cell.frame.height
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isTapScreen = true
        addNewTableView.isHidden = true
        self.listImage.removeAll()
        
        title = listChapterStory?[indexPath.row].name
        DataManager.shareInstance.getChapterReadBook { (result) in
            self.listImage = result.image!
            self.navigationItem.title = result.name
            self.pageNumber.text = "\(self.pageNow + 1) - \(self.listImage.count)"
            self.collectionView.reloadData()
        }

        
        print("Click \(indexPath.row)")
    }
}

