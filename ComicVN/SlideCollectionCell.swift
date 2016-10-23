//
//  SlideCollectionCell.swift
//  ComicVN
//
//  Created by Enrik on 10/5/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Kingfisher

class SlideCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageSlide: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  
    var slideImage: Contents?{
        
        didSet{
            
        }
    }

    
}
