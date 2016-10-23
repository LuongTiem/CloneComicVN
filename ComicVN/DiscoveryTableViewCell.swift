//
//  DiscoveryTableViewCell.swift
//  ComicVN
//
//  Created by Enrik on 9/30/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

 protocol PushStoryDelegate {
    func pushStory(story: Detail)
   
}


class DiscoveryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonTitle: UIButton!
    
    @IBOutlet weak var collectionInCell: UICollectionView!
    
    var category: CategoryStory!
    
    var listStories = [Story]()
    
    var delegate: PushStoryDelegate!
    
    var detail : Detail?

    var discover : Discover? {
        
        didSet{
            collectionInCell.delegate = self
            collectionInCell.dataSource = self
            collectionInCell.register(UINib(nibName:"DisCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
            
            buttonTitle.setTitle(discover?.name, for: .normal)
            collectionInCell.reloadData()
            
            DataManager.shareInstance.getDetailCategory { (result) in
                self.detail = result
                
            }
        }
        
        
       
        
        
    }
  

    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}

extension DiscoveryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = discover?.listcontents.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! DisCollectionViewCell
        cell.imageCover.kf.indicatorType = .activity
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            (cell as! DisCollectionViewCell).story = discover?.listcontents[indexPath.item]
            let urlString = discover?.listcontents[indexPath.item].thumbnail
            let url = URL(string: urlString!)!
            (cell as! DisCollectionViewCell).imageCover.kf.setImage(with: url,options:[.transition(.fade(1))])
    }
    
  
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         (cell as! DisCollectionViewCell).imageCover.kf.cancelDownloadTask()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate.pushStory(story: detail!)


    }
}
