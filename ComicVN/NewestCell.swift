//
//  NewestCell.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/7/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class NewestCell: UITableViewCell {

    @IBOutlet weak var update: UILabel!
    @IBOutlet weak var numberNewchap: UILabel!
    @IBOutlet weak var nameManga: UILabel!
    @IBOutlet var im_view: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var setupCell : TopNew?{
        didSet{
            update.text = "Update: " + timeStringFromUnixTime(dateString: (setupCell?.updated_time!)!)
            nameManga.text = setupCell?.name
            if let totalChap = setupCell?.last_chapter {
                numberNewchap.text = "Chap mới: \(totalChap)"
            }
        }
    }
    
    func timeStringFromUnixTime(dateString : TimeInterval) -> String{
        
        let dateTimecovert = TimeInterval(dateString)
        let date = NSDate(timeIntervalSince1970: dateTimecovert)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
        
    }
}
