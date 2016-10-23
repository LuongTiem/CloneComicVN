
//
//  ViewTheLoaiChiTietVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewCategoryDetail: UIViewController,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet var table_view: UITableView!
    var naviTitle: String!
    var id: String!
    var storysList = [Story]()
    var allStorys = [Story]()
    var filterStory = [Story]()
    var az : [String] = ["1","2","3","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    var detail : Detail?
    
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.delegate = self
        collectionView.dataSource = self
        table_view.delegate = self
        table_view.dataSource = self
        collectionView.register(UINib(nibName:"CategoryCell",bundle: nil), forCellWithReuseIdentifier: "Cell")
        table_view.register(UINib(nibName: "CellTableView", bundle: nil), forCellReuseIdentifier: "Cell")
        title = naviTitle
        loadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    func loadData(){
        
        DataManager.shareInstance.getDetailCategory { (result) in
            self.detail = result
            print(result.name)
            print(result.related_comics.count)
            self.table_view.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = detail?.related_comics.count {
            
            return count
        }
        
        
        return 0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let urlString =  detail?.related_comics[indexPath.row].thumbnail
        let url = URL(string: urlString!)!
        (cell as! CellTableView).im_view.kf.setImage(with: url , options: [.transition(.fade(1))])
        (cell as! CellTableView).setup =  detail?.related_comics[indexPath.row]
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! CellTableView).im_view.kf.cancelDownloadTask()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellTableView
        cell.im_view.kf.indicatorType = .activity
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStory = storyboard?.instantiateViewController(withIdentifier: "detailStory") as! ViewDetailStory
            detailStory.getData = detail
        
        self.navigationController?.pushViewController(detailStory, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:40, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return az.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCell
        cell.lb_AZ.text = az[indexPath.item]
        cell.layer.borderWidth = 0.3
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterStory.removeAll()
        for story in allStorys{
            if let letter = story.manga_name?.characters.first{
                if letter == Character(az[indexPath.item]){
                    filterStory.append(story)
                }
            }
        }
        storysList.removeAll()
        storysList = filterStory
        table_view.reloadData()
        
        
        
    }
    
}
