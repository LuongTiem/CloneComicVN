//
//  CellTableView.swift
//  ComicVN
//
//  Created by tubjng on 10/3/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellTableView: UITableViewCell {
    
    @IBOutlet var im_view: UIImageView!
    @IBOutlet var name_Manga: UILabel!
    @IBOutlet var chap_Manga: UILabel!
    @IBOutlet var lb_View: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    var setup : DetailStory? {
        
        didSet{
            name_Manga.text = setup?.name
            if let chaps = setup?.total_chapter {
                chap_Manga.text = "Số chap: " + String(chaps)
            }
            
            if let views = setup?.view{
                lb_View.text = String(views)
            }
        }
    }
    
    
}


