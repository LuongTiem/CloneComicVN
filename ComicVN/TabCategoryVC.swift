//
//  TabTheLoaiVC.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/27/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class TabCategoryVC: BaseViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
  
    
    var listcategory = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Thể Loại"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppCell.self, forCellWithReuseIdentifier: "Cell")
        loadData()

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)  as! AppCell
            cell.imageView.kf.indicatorType = .activity

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let urlString = listcategory[indexPath.item].thumbnail
        let url = URL(string: urlString!)!
        (cell as! AppCell).imageView.kf.setImage(with: url , options: [.transition(.fade(1))])
        (cell as! AppCell).nameLabel.text = listcategory[indexPath.item].name
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! AppCell).imageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listcategory.count

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width/4, height: 140);
        
    }
    func loadData(){
        
        DataManager.shareInstance.getCategory { (result) in
            self.listcategory = result
            self.collectionView.reloadData()
        }
        
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryDetail = storyboard?.instantiateViewController(withIdentifier: "categoryDetail") as! ViewCategoryDetail
        categoryDetail.naviTitle = listcategory[indexPath.item].name
        //categoryDetail.id = listcategory[indexPath.item]
        self.navigationController?.pushViewController(categoryDetail, animated: true)
        
    }
    
}
    
    


