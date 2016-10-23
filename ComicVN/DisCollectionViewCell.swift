//
//  DisCollectionViewCell.swift
//  ComicVN
//
//  Created by Enrik on 10/3/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class DisCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCover: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    

    @IBOutlet weak var labelViewNumber: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    
    var story : Contents? {
        didSet{
            
             labelName.text = story?.name
            
            if let view = story?.view {
               labelViewNumber.text = String(view)
            }
            
            
        }
    }
    
  
}
