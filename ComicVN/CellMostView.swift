//
//  CellMostView.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/9/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CellMostView: UITableViewCell {
    
    
    @IBOutlet weak var viewLb: UILabel!
    @IBOutlet weak var numberChap: UILabel!
    @IBOutlet var img: UIImageView!
    
    @IBOutlet weak var nameManga: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

    var setUpView : TopDownLoad?{
        
        didSet{
        
            nameManga.text = setUpView?.name
            if let numberChapter = setUpView?.total_chapter  {
                numberChap.text = "Số chap: " + String(numberChapter)
            }
            if let view = setUpView?.view  {
                viewLb.text = String(view)
            }
            
            
        }
    }
    
}
