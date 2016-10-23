//
//  CellChapter.swift
//  ComicVN
//
//  Created by tubjng on 10/4/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class CellChapter: UITableViewCell {

    @IBOutlet var numb_chap: UILabel!
    @IBOutlet var numb_view: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var setUpViews : Chapter? {
        
        didSet{
            numb_chap.text = setUpViews?.name
            if let view = setUpViews?.view {
                numb_view.text = String(view)
            }
        }

    }
}
